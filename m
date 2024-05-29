Return-Path: <netdev+bounces-99189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43598D3FAD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 22:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E632D1C22052
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148D21C68BA;
	Wed, 29 May 2024 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BakYNuCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AF21C68A6
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014865; cv=none; b=ShjM9GURB4wjDUFtXuUXhq1CRAQYS5EpjTMrYMM9fLRNbw+X8E41Vg4DkQHAcgHd8TksgO5x0MAN+Ay/gmRQMy1MP+fHnwGTzRJmGP61lV6p+17EKk9wYHO+yyXpKQZ1JmOqt/0WzNlos2+T7LSdbxf0zkHR20WMJJQlbqEwb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014865; c=relaxed/simple;
	bh=Wo98MKUhA7vphZkxROo0SOPk8ZWA0Q9xpKVPoNUQZik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q45miApCAP0d0GdngJ8Dto7o/Zko9UfX8y1gAN08/J+/ru1XFVF9T9B8tTW50bWTnaQTZrfhNX54j9/PtaiTwSZBgZbHeW97++W5Ose/Stf/okcZHrDeZLY9FTmkYHa4JBAHJWA7aAXbNOKXxRTJE5b+JuIQrbLQG7fWYyjvphk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BakYNuCo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df78acd5bbbso195147276.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717014862; x=1717619662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo98MKUhA7vphZkxROo0SOPk8ZWA0Q9xpKVPoNUQZik=;
        b=BakYNuCob2aCTrAdXRyVYk4TbanAF2NGI1oPC/F3Mye1tsubA9poNDqBVi+P7Z7LU3
         bkpwMb9HSGAhsJUIdL7jgVuGSpJREzG/yE1qAshRsFd5J5FLN0f4ZdyUesV3IcMAE0A5
         1Zc+Z+XJjvagk7WQ5e4SIpsv43vhl+LN62gWjo/z4Snsq9kGLV6nz2frDYETPs1WMRYW
         MmVqet2CiP2Vzoa5XVmgFe44+5WIAo6qTy/0J7+Q2hXgkhWPgtQ1habJR07DjMqlvpX+
         AvZ7lxj4i+KTkpe4W1NwFhxwuDIyejbNj0nCpjpV1Dr93GWCyY3+NyZmqql5DciE7yRt
         HbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717014862; x=1717619662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo98MKUhA7vphZkxROo0SOPk8ZWA0Q9xpKVPoNUQZik=;
        b=AUTIVomHPWtvZLt43jpLvPmeMtzkCv4bO4NEgo7cdcBLiq0NwSgwvgKmv7yxRXrS/2
         cz+antuTUf+WIL3jVLitrDVcICM7Qpqy01TSnwf/HVKvc5DqjAnsftkpPS7K5GS6uCsh
         j6GP6CHcO9nbwU0wkJYmH2sPKAx7rwehIIP2iAO1o4HDGTmnaMV8Syyf2/XZ4gQb+4/6
         UGxtm6EdaOvCekHWovacF3/+ZuTbF6nzRPS9LI+1KFI2nnV7mVj+p4wB6CjySW8eq2KP
         ei0MUF7jI8NXpOowbzwvQyhCNURGc2fgc0BpsO3C0B6v9RXtSAyEcax/nUFTg6VxAfoV
         FDxA==
X-Forwarded-Encrypted: i=1; AJvYcCXpbZ6EMz3rENclfD+QxaoxGhSFMd6YpiYzYpg0LKObq+D9KBfxNzTkj7EYIV60v8yfVp1spQZkYd6wDvwUi0E5Wx0UZJQP
X-Gm-Message-State: AOJu0Yy84NVyiSDPTRb3y7Dqp2zhOW/17rRePh/Gt7LxXTb50WMDbqB3
	8rQpAI+cVrbFL46itUhIjoJU+m72qUalDjZex/aS0/873Zoui6AlJOYS8HzViMU5+dxknnUXJX9
	vU6osnr7RfTGnDw==
X-Google-Smtp-Source: AGHT+IFYNKuuJ8oAN104B0CeM7NXmWIe+eo6kHNMzVn2A2si1R1XOZARqdEe0baO+zX9r936ZzuuKmAlDTDc79U=
X-Received: from jsperbeck7.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:26dc])
 (user=jsperbeck job=sendgmr) by 2002:a05:6902:1548:b0:df4:8ecb:ae57 with SMTP
 id 3f1490d57ef6-dfa5a689030mr29161276.10.1717014862662; Wed, 29 May 2024
 13:34:22 -0700 (PDT)
Date: Wed, 29 May 2024 13:34:21 -0700
In-Reply-To: <20240418073603.99336-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073603.99336-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240529203421.2432481-1-jsperbeck@google.com>
Subject: compile error in set_rps_cpu() without CONFIG_RFS_ACCEL?
From: John Sperbeck <jsperbeck@google.com>
To: kerneljasonxing@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

If CONFIG_RFS_ACCEL is off, then I think there will be a compile error with this change, since 'head' is used, but no longer defined.

