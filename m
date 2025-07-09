Return-Path: <netdev+bounces-205497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2685AFEF64
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 19:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A365C1F27
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFB82248AC;
	Wed,  9 Jul 2025 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3q9pn0d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA82236F4;
	Wed,  9 Jul 2025 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080801; cv=none; b=bLwBLfYRcBSiYyuZ41gRC9PGNw8k3qv2pxiVXKfeTPt82cnFjr9AMbfWJYH5EwY2N8icmnMXpOkhV1VhhDsCf03+Y5py7GRHf5Dpai+RCfdJg5H9uiteCUrjF65fO+R8HMrjOeihDcDXjZt9iL7rFuWHlwpVZ9zXuAl5ns61YNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080801; c=relaxed/simple;
	bh=PCsRHb16/w6OPdQuqT/+FEz8a7zxthYKUoQWvwGfHyE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XgX1hAraMGHhjPwnrnoxxouBCw4z9IWppjlwTwbISn6fKmwYFeJdEnMzP97JcNi9X+pmx6MiGkvqin8emH/pnLat4wg7P5VaerUHjx2U+j88uI1wmGfXC/6R/gTQsjPQv7dft4ptaQlASkwV1yjy0ax2qQHuArXk2M19oxqBw4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3q9pn0d; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e81826d5b72so27432276.3;
        Wed, 09 Jul 2025 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752080799; x=1752685599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKSNNxL5WsDnDxC3c90ixMXQtVsa+mzdB9YIiLJb/GM=;
        b=K3q9pn0dsccBMDaF4nIIXByTcbcpnut14ocMZBp5NOP6uQ9gTy57K7/pK+Ho9HBuYD
         lSg3jpgwNONVlOAdrHfxMmBPvVRHNr3sxyLmwlcprQj7cpsyTPF1X+xPrF08RYRtyUG2
         IxD7SO3lqD5dKwqjRvPf4ziIh0f/W3LevsbsICN8LU5Mwl2gwguE2cJLGUS2nulaZn7y
         mrA2v1RkdGQ6t5OFAJcTYv/oJZpz76leqMKHQhUWgdWLjx6tginYG6tTuPlkRMl8Uxhf
         KcnGWZhL8Xj3ljLX4Et7/idp8dpSCv0izl1res2TaF3wbFvYUG4SnYTa6EdJ6XBqqgiS
         3Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752080799; x=1752685599;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JKSNNxL5WsDnDxC3c90ixMXQtVsa+mzdB9YIiLJb/GM=;
        b=j4FF6LGpLo+VOKLVaNVLZgHowdXDhBNClo9EOUeIsBke0r6XsrllU+FaUu/esI3rXs
         As4QhivIZRSZ2QUnRazq/WEJWfz0v+WuzSnoWj/O4qGNc9woxHkcRww6QaDAgX5bZxxr
         yF/ThgWcMl+P85yU3pJKdszbLErmUnBUaefyFNsDbsXwfSLiB+WZ01PYv8YP57v5a/+S
         hbpCEe6Z9y4e+3Rj1VKnfqL1MCrPvO2NlXnNaaL4ybSzn64ziJ0PIWIVy3RacFssORQ3
         cIbqdL5D4LJEbD14RvCB+IL2kLUBDJ4L4tHG+fEx9tISfC9e+gK3VPkV8YvGV2JoP9PC
         /UcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZQCUIoF+vY8v4aPHKhZLQCuPQl5xB6f47pIjnU6Qn/RzY6MHsLoYLq2S3HH4fuSSIFfMLw+Yzbax7HvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzydhD9FR0liRc3YlTo5LnyVZEIwpMdgVTs6u2+IA9/89B+Ux9N
	XMViZ9oHQoyVWCJcshAnbrHakjWBmu/efIgI1lVZ/o3pOvD09Ka4iqhq
X-Gm-Gg: ASbGncuBraoEPOgLqpDDA0QOGdo9xrVwVgOaDj15sP9RZNnnwB7ggVHr5KaMhlrn3c/
	RGV2O0AqBOa3ne2s2zwGl20EaoxbIOlsaKJitgJt45HMbAmaK3h+gS5Ms1Cf+Ir+UfPa8dZvMwR
	7OKe6h8tHQaeRijAHp40jFSKWzuKjPQDMU7SwaR/Azcx8zzeWg3xUZxpjjlLMufFin8W1EhqV/Z
	e5ofPMDnoUtkea7KSLGGI7zOS5KENo4EiyRhAzUwbAUSd+SwyWtzCLHJMSPnwfhi3xoRX4IlI7b
	rjs2LwAr27ZRf5zkQ7Wuhid38/tLVOzM3Gis/6ytWyVfIbJYG15ZTnw9GR9YZc5MCB4+ikQfVR4
	gjoZFEegX6ASuCzH+bPRxZpu9UNtSz94uAHOCXi/jr/2aOH5XRg==
X-Google-Smtp-Source: AGHT+IH+VORUh2t2kr4QaWB2b6rEwtDKXQx0qvLvW1/lu6Pjwzs5YpBiAZaSctfVyzxx+55Pa1iU8w==
X-Received: by 2002:a05:6902:5005:b0:e7d:ce24:636e with SMTP id 3f1490d57ef6-e8b77e15710mr294385276.31.1752080798754;
        Wed, 09 Jul 2025 10:06:38 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c4b3424sm4102244276.50.2025.07.09.10.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:06:38 -0700 (PDT)
Date: Wed, 09 Jul 2025 13:06:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yun Lu <luyun_611@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <686ea19d859a5_a6f4929455@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250709095653.62469-2-luyun_611@163.com>
References: <20250709095653.62469-1-luyun_611@163.com>
 <20250709095653.62469-2-luyun_611@163.com>
Subject: Re: [PATCH v3 1/2] af_packet: fix the SO_SNDTIMEO constraint not
 effective on tpacked_snd()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> Due to the changes in commit 581073f626e3 ("af_packet: do not call
> packet_read_pending() from tpacket_destruct_skb()"), every time
> tpacket_destruct_skb() is executed, the skb_completion is marked as
> completed. When wait_for_completion_interruptible_timeout() returns
> completed, the pending_refcnt has not yet been reduced to zero.
> Therefore, when ph is NULL, the wait function may need to be called
> multiple times untill packet_read_pending() finally returns zero.
> 
> We should call sock_sndtimeo() only once, otherwise the SO_SNDTIMEO
> constraint could be way off.
> 
> Fixes: 581073f626e3 ("af_packet: do not call packet_read_pending() from tpacket_destruct_skb()")
> Cc: stable@kernel.org
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>

