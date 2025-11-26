Return-Path: <netdev+bounces-241755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19493C87F5D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0A164E03D6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B16C26FA4B;
	Wed, 26 Nov 2025 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNS7xto2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045469463
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127993; cv=none; b=Id/bzP5fJ900K8C7JT5CFnmwk3//EvYFV4/gpsq5jH2rXap6OMw5EupsNdZsdbmX0CfQHQ0nIQOqijgQpevTbfeYOt0Vb/c87qntfSpmne56qq5663H0lv/L8hwCdCfeJ7+VQ7S1cUQ1EmaRH3dWxn7c0M/oH9+6I3dQFHkYuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127993; c=relaxed/simple;
	bh=9AYU7nTBQ7AieP6zX4aFc+C6RLQ9yiDUgGNV9ZfxJIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4GmC+gKKqYEipgJJuNkyPTo2Lye0i8YxjwM87P2Uec0BVt6p6qw56j2VYpz0STQ+vObsCs6FgJG8gLokRufaYzsvUkSUDeyuh/9MxCJrSVJdH+Xphaw92LcyWoHO7Dusvgn0N3aB8szVhKlvjCWIWlNkOad3bN6pefAjgEL0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNS7xto2; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bdb6f9561f9so2792003a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 19:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764127991; x=1764732791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AYU7nTBQ7AieP6zX4aFc+C6RLQ9yiDUgGNV9ZfxJIs=;
        b=hNS7xto2uE6bLe/srsZfG/vcoDscubcbEud1Pbl7tk4dCz3SQ18FFdr+yAQf4IjooH
         yKAD/Kyt6pAjInWRFBRwPjPDvrpI3WzjiP6kuzEpiZAkqCFqOp5K08l8DTkLe7ffIYnM
         d2LlD+GDTfqseroeQdbCj1MmMKuRJbbqw+tIOntQE6lVOJbSrS8ZA90QSulIM5rjTJMO
         7Nx+Iq03cXHyqQ4MkUvkhC+GZKuTxUzbVuPUdp1nq0tUbbey9qmGb52Iu1RZ0yY5oest
         Tl48JxvMblzlJDNgip8b/Nv5uxD/jheRtV+XdyMahqdK9VYiM4WwQWJljXj07GLT5cN6
         SixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764127991; x=1764732791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9AYU7nTBQ7AieP6zX4aFc+C6RLQ9yiDUgGNV9ZfxJIs=;
        b=lk+R/W3+28J+MJnIMHDTSgz+ooSfOPT/qWhm4kUeHmIPGrvGCplLZVTYzD+9sS36wY
         JRvryfMiNJk62fZ+e2CVF0vKWcBIbdOKLubWVktY8ozSmmsQeA+3YdKMpuoJ20zoV+nI
         bbAjqyfS3HbCSf23RB55ofkqjOx2L+TB8M/aLqpx3cMf18tMlNkZQ65FTtoJ5DfCVJQi
         xnZdCKN46M053qO0TUDrJyWI3uARXNNYuvRdkaFrno/RzOqalDyFmLQYQWpLERg0pMUW
         FViHfBcBLjfZMpIYdL0x3dmEEDiwLMtuwfBXgzPyGrY6qIUwUsUaJ5WvI1AL6vn/pJcB
         BCwA==
X-Forwarded-Encrypted: i=1; AJvYcCWAs05592z0KBgkz0ehJw/liV8xoqJFdtTf+1Aayd8CmJ02AlboiywSAVi+r3qcuuIymgVAEKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwdf2sFOHLTmzylKJQzTflWAy7XT0k7xGgzpBRNR6gSA/vhx+
	zWK6t9BpLWrMH5e4RhPacIzCeAiHTnnu+lTNxMTCPleeW3wrsWFTPr4Q
X-Gm-Gg: ASbGncunlgyUL3DGHVciyeh9uvqJjSsGmE5YykOZ9BUqVOYNobEj+2IDPKlhUTRTt4G
	Mb8IwdzjzhwjBrH8eFdjn4ir5vMgdGnLnr+BnS9gPHXsFh2YQdtVMUJ+Xz0XI8ugppcANI3EOE+
	emI/9NOoZB6eeaEB6njWSEXxJG2xZb6zSlV9T7/KXyfOTzkLCrxX7qv1eiu7DFl4FMPNVIqLlbm
	hW3+4lAoF6yoUe/1banccO9IgFHPMSctPJpMpw2TeRXeLnN20OFU4v1/Gw4mbYA9ToDCi+X2ASf
	lmFCsEdjKxQ3907PW8I9yPStSykP7Zp62jkFRorSHaQV0u9klt0OJVZ8+5gFdNumjIE7FETUlmf
	r01GH3UASfmQh+2hQH0LIWPuuHknanmnDbUrQ+GCOkc8QU5C4AuKuqVN5MdqBtENMu7o=
X-Google-Smtp-Source: AGHT+IGS2oO87NUrSeYzQeWUCJcrvZ7y68fw5wrJGKf2sacKyt+I/xxsIQXZzLuT23ezIEryAk166w==
X-Received: by 2002:a05:7301:da0b:b0:2a4:4f6c:53b4 with SMTP id 5a478bee46e88-2a7190a5f6dmr7963362eec.11.1764127991147;
        Tue, 25 Nov 2025 19:33:11 -0800 (PST)
Received: from gmail.com ([2a09:bac5:1f0b:3046::4cf:1d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc38a66bsm67334756eec.1.2025.11.25.19.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 19:33:10 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: Re: [PATCH net-next 04/16] netfilter: flowtable: inline pppoe encapsulation in xmit path
Date: Wed, 26 Nov 2025 11:33:04 +0800
Message-ID: <20251126033304.6588-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125223312.1246891-5-pablo@netfilter.org>
References: <20251125223312.1246891-1-pablo@netfilter.org> <20251125223312.1246891-5-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Nov 2025 22:33:00 +0000, Pablo Neira Ayuso wrote:
> the pppoe device which delivers the packet to the
> userspace pppd daemon for encapsulation.

This is not true, PPPoE encapsulation is done in kernel
drivers/net/ppp/pppoe.c. But inlining is still faster than the original
xmit path because it can avoid some locking.

- Qingfang

