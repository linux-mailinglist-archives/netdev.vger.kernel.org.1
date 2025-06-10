Return-Path: <netdev+bounces-196232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CDDAD3F9B
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 18:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA467A0629
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E6E242D6B;
	Tue, 10 Jun 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qumulo.com header.i=@qumulo.com header.b="lmC68gaW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787D23AE96
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749574479; cv=none; b=ZI2a2w0yACu9ckWJBdg0cz4QK1L0l66WxjcEBixgMLR3DIWfXkMobC8teP2j6hNxKmYzWakZl8yfqTaFoIlWRWzN6rA4Hlnl1vWT4f7l0ctWWvFLJnw1AZv6vZwUmUAqsqIAomBhT74deMnvFNUzdHNkCNKjLKXBagSNRyYhQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749574479; c=relaxed/simple;
	bh=mt3soXNDfq2pJoAQ2Rbfgn/0tXLNN8vqGxuyoKsK2PQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=G0mYZzxWdAzANNsU/8zV1uH3B93enk8Kr7e0Cskcq8IT67EcWHGaEcSS8ATOysCMNEXtv4v1FFeK/s6s3k9tzF24EeGQYy2hx+OQ+RXxozeBUysQvkY4neQUfSxd9q/pq0+ApXXXzHuZo21YP8EgwECZE8CkOpBX065ECTA9VsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qumulo.com; spf=pass smtp.mailfrom=qumulo.com; dkim=pass (1024-bit key) header.d=qumulo.com header.i=@qumulo.com header.b=lmC68gaW; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qumulo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qumulo.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313a188174fso27940a91.1
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qumulo.com; s=google; t=1749574477; x=1750179277; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mt3soXNDfq2pJoAQ2Rbfgn/0tXLNN8vqGxuyoKsK2PQ=;
        b=lmC68gaWfQgc0enIFn1HV3aESqqxZr+LC9ptbiOs5YnQTCnlWoGi1X77kd/KR+i7Gi
         gcIfqOKn6YWywr1F44eQdO17V9SVaVTX9quLX5icX12X0097rgSJIO4Q7TUYk9YDMUYR
         dbsZFx2GYhmgRqmOJe3lBBj+KdjmQOfgdNo/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749574477; x=1750179277;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mt3soXNDfq2pJoAQ2Rbfgn/0tXLNN8vqGxuyoKsK2PQ=;
        b=DWZtPTF9jovkjtZrjwDTmvL4sLRSGUxtbwXaKJpIxBH41Jyu07yUqlHoRiEjhVek4J
         NnVx7vkxuWlXZHpikv+e4Ztsso8Z1GDhpVuMDDghYncRiCQg0dUtRUQ1hYyZe9Kz+9IK
         1meAA4a0yVUEnWFlgO4pOZ+HHTH/oDc0i7GVRun6EI12EAzCtjZr/UQmOzOa3rpvqlQg
         wDM03Nzih+2YEmg2ILMJwVayk0RYwNRcjXjp3sNzPbobzZhQ63YIjw4DXn3eUiNFIhRv
         hSO7B5X7xdIdkOp89359BgvOOfGDZKjfDVPmpoeb4w/AIIYae/itjA7xpGrXMNVxMsex
         Sr1w==
X-Gm-Message-State: AOJu0YzRCMnuBO1dHQolCA/inRGgRH/xJLquFWGy7HqwrEkTqBwbW2pJ
	lx7MUgAI/ukZuAII4SlBOHQdqrwCyXqqbyDROb9SG8xHpFoUcxwG1ibT6Y7W1MikhfAeSBGz2U1
	/EbCS4rPnNDuGrGnzFromJRe2ty9hxtTqmT7c8mx2Ad9ubTnhDBJrxt4=
X-Gm-Gg: ASbGnctl8q0pAPL6YkozbJEBbnFT13iAtdPgIvj6UNFhod0BGa4C3uE3NcU2Csk/g3f
	qHXlSzSEABdUYQqxgEX/1ixDzFigSsT79D+8+v5nZSx5HbPGd9iasV/98SJ79wM442xflaYkcU2
	drSO/53nqfwyy3z/AM39eHDRpsHPnCxmJuEm3lh54be8d2s3wwSOB8
X-Google-Smtp-Source: AGHT+IF5we/SYOxJ1qLL56kbYZVbMvig/6sV2CaJjzn8LDBnCNX/3E0vdybpMy4qloixKSb28jQhalMQA+BPdog9Dy0=
X-Received: by 2002:a17:90b:2dca:b0:310:8d4a:4a97 with SMTP id
 98e67ed59e1d1-313af9858a5mr148037a91.15.1749574476646; Tue, 10 Jun 2025
 09:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Haylin Moore <hmoore@qumulo.com>
Date: Tue, 10 Jun 2025 09:54:25 -0700
X-Gm-Features: AX0GCFu0zOGGpEaS8pXlMuePYPYFnRXwPK9VsM4vdK_z8M90sV_29HvrasJ1z8Y
Message-ID: <CALnKHDCKs-_XvW0jFAu1yv-Ex_OabqzuyBy=US_W-jzwy9N3Ug@mail.gmail.com>
Subject: bond_eth_hash only uses the fifth byte of MAC address
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello All,

I am currently digging into the source code powering layer2+3 bonding
and saw that for bond_eth_hash only the 5th byte of both the source
and destination MAC address is used in the XOR.

Is there a reason for this? I was not able to find anything searching
the mailing lists or the web. This functionality while documented just
feels weird to me.

Thank you,
Haylin Moore

