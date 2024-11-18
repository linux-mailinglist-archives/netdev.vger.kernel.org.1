Return-Path: <netdev+bounces-146018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98F9D1B36
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 23:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485041F21DEE
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300B1E571C;
	Mon, 18 Nov 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G307fCf2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF2B183CD1
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731969992; cv=none; b=AwKtJyAKd2JWcWbSMOTvbST611xgsi9KR4achtR+lLbNAIO+uS3pjipQpxo3bbGiKYQkdyTG0alyXlSp6qZC4qnjkr31A/AVh2LWnlGQILUISPxbtRSGl7hDfuSCSnS60lI4y+6pPO1HiMkDs9s5KPh4xLpqecOjdlQx/4u4pFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731969992; c=relaxed/simple;
	bh=jVdNToSqpDLGbGMT9HIvsjq7ZZozGMIwAHm46LLln6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPBViSqcFdw63gGg/TKXFziXB+dIO5xJIsuoIQjUK9t/eoPa2u/O16OMHm6k4CuwXnLx4J/FWnmNMNr3MEIQhrk2uA0qD3tmzF535kgufvDFgmqNikQVreFRcTov20bKpCn5ew2JLg6qPwxxyeFvdjFIAHDtPIxaxURqDb4dsvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G307fCf2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731969990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVdNToSqpDLGbGMT9HIvsjq7ZZozGMIwAHm46LLln6U=;
	b=G307fCf2XCx1yMijG68frLylxlcGC+QHaAptgMbc3fkNw4RnNmVkd+O4vX4GT9C3K3qpS5
	3g9SIDBZHms9HcFxrzxcL9mVKgF5eI+JFxBfmprOzv1RA5VXwa4kKCiv0wgmxQy/RsTutk
	/ywWfOGJxRz+fXWXyVRMgLiIJiQPK00=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-yxVE5WNXPbGdAM3wizypZA-1; Mon, 18 Nov 2024 17:46:28 -0500
X-MC-Unique: yxVE5WNXPbGdAM3wizypZA-1
X-Mimecast-MFC-AGG-ID: yxVE5WNXPbGdAM3wizypZA
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e38797ab481so4636117276.0
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 14:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731969988; x=1732574788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVdNToSqpDLGbGMT9HIvsjq7ZZozGMIwAHm46LLln6U=;
        b=ZTDXz7iPCZLMrSPLME2v1RGo3BX4lVlfxWNMJAiktmGbO1H9wYmFxsrjhJG+cPfGVb
         Q7+xrjIYqj9PSn72YiimuCUB4ub3B93Ldb1cWmHvKAnUOl8X33ROtCKnh3FgLQR7DBR+
         7Xmp1ETNy8ZtGU5lceE08oj8AaJluI5IURn+yZG5m2vJMFX10NiaxGRJtcCeMsaOIkX8
         wsctwCw1dqJfZQkCVOGN0jn6fKMSLSRpA8NbhhpnZZqa1MJ7fnuOwfpSGB7rBhIJc4Cm
         guMrUQNSPPZs+eVLMyRq9Re+iwJa3UatLQgm6U84lvMqHMaMRaEdBNhrr43CVdyDT7py
         83rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWhjG0Zdn0dxa56TFC4chibPPRFy6QCtigxNynt/hhqlAlksI00EG9CjgOumSS3SXq+xo6wL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySMDoMGvA6Z/b31e6sgXnGcjq+jjUcdYlXQS/CwdMc5cOdEe4k
	8sinG5QIMUaGX2/YV+mgxkBkx7spYZnjXkobmGYOEy93F2BKAncgOhHKj4wDORNkks5wRyzA/A/
	85K/c/Bb0bQzfSvoSbVko/uritXwnYKWfFDlegPAcM4Fuk2ME8Xz/vORcO/et1LnRwcMQdUOmQZ
	5GtG0P3TRJL6wIWUv4x44UKDBLFg6c
X-Received: by 2002:a05:6902:1546:b0:e2b:d5ab:986f with SMTP id 3f1490d57ef6-e382636c2e8mr9943490276.31.1731969988209;
        Mon, 18 Nov 2024 14:46:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGa/yJCaJceBDAKRd5HIs7k1n9AS+YagCggtT85jE/crz8q3O/CG1CMPPEIdGCDKA80JMF1Sp/DJawz1vg7VUI=
X-Received: by 2002:a05:6902:1546:b0:e2b:d5ab:986f with SMTP id
 3f1490d57ef6-e382636c2e8mr9943484276.31.1731969987988; Mon, 18 Nov 2024
 14:46:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116094236.28786-1-donald.hunter@gmail.com> <20241118180133.54735-1-kuniyu@amazon.com>
In-Reply-To: <20241118180133.54735-1-kuniyu@amazon.com>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Mon, 18 Nov 2024 22:46:17 +0000
Message-ID: <CAAf2ycmZHti95WaBR3s+L5Epm1q7sXmvZ-EqCK=-oZj=45tOwQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: af_unix: clean up spurious drop reasons
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 18:03, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> From: Donald Hunter <donald.hunter@gmail.com>
> Date: Sat, 16 Nov 2024 09:42:36 +0000
> > Use consume_skb() instead of kfree_skb() in the happy paths to clean up
>
> Both are the unhappy paths and kfree_skb() should be used.
>
> I have some local patches for drop reasons for AF_UNIX and
> can post them after net-next is open if needed.

It would be really helpful if you could share the drop reasons you
have assigned to these. I am seeing ~100/s coming from containerd
which I will need to investigate if it is any kind of error condition.

Thanks,
Donald.


