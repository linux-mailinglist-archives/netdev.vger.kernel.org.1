Return-Path: <netdev+bounces-64725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EA1836D7A
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E48E9B25948
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 17:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F249A6DD19;
	Mon, 22 Jan 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbACEdOE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D755C1F
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940967; cv=none; b=bSOZ5+6A59W55ie7OMke9b+Z3kcS79Yb7S9jKk9YIJ4+IXiuOiIfOKo0V8zW6jtJ2vocNbx7nos6LwH9r/waq4HTO8CUcsTvGRYxXekRcvcqjgFJ8fTFYWHAZMmJM8oTVSbtpRqRcwNkvxXXcoIRe3lJYKq8Rof06jTtQ0FMHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940967; c=relaxed/simple;
	bh=v8wA3jLOZJ/eb+BHxL4tb+bnBAWueHg4dHy0UpCFnzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMADYN/riDtENEluCnErHNwO9ZmP7jncl4cqGIEUKLSV6wjrR9R0ENchFuEU9n2fJyE+pKESMfCzp3xNUoL0zIeY/YZ5kI+hSH6AOMSXZ+mOKfY+TFNbszUuOQpWTPUwraFNfCfY3P5wA8d9cmA1Ahk2/FBqs8eoBUR+L8BMUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbACEdOE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705940965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VtGrSE7bV0H1tDYZEUSnyV/a5SzmZIiqIPKMQ42T/v4=;
	b=IbACEdOEZSNv/fBrynp7wm+aYcWVY9/XqTgpHZVKcbmlPviK4qY+5R6X7Cbyv4gcDFH1nf
	70R/82hzMG/xx4Kb6FjiGWvWCDy8dI+/Kq7EZrubN5G5/Kd3YvWBYrXc1x5dSvV4WXCPfC
	3LmWPcMBSHg/rlFMhKR9RMY9GvNm9dk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-9_GX3HbBNauO1O5W_9nbIw-1; Mon, 22 Jan 2024 11:29:23 -0500
X-MC-Unique: 9_GX3HbBNauO1O5W_9nbIw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42a3e4e9155so23735861cf.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 08:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705940963; x=1706545763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtGrSE7bV0H1tDYZEUSnyV/a5SzmZIiqIPKMQ42T/v4=;
        b=tpxDwdD+lM9uEb7scYOrChbEJrXlrsNIyVjgFyCWYYziczJ0P8u0mN7sz1+Wg7LzVN
         3NbNNYkhMoZHKqbBzqzOCFdQcel7rfKJK3AAlYmip56fsECYaq5Db2eMr/HoQDpCiEs/
         TOyc61OT537etGGWl0YBZy/s3v/1g1An6dZPEKbalbSRVlu+Zmx6vyNEW098wNZvULJX
         xk4T/yUCF0XbJmfao9lRFI508QrYCesK8mb4nWgAR6s0WuzgpzodFc2+AVp1+pXYdab0
         NFuDvScjJORM9AZMgg95oajA2LcUVL+BuHLdd/pk6nkqfQYL4svSQvuF5dz5/HmStd3r
         t57Q==
X-Gm-Message-State: AOJu0YxQS1Y7mdQ3u5BZtXEI/VcqtWxd3Y/qDZ0y6nmecEqjMFmFHti3
	tylsLaU/qut9W87wHByRKcFrOPNyxsinRnQ28QvmL5ic0Xu7BcwVB++xtZkPewzoNuJ/Z5Z+Dzd
	Da5CS3W9Cbe5eV6JUBs2wcwchM11VG7iCcvYZccKD+hxnB0v3b/YTsA==
X-Received: by 2002:ac8:5748:0:b0:42a:4392:3119 with SMTP id 8-20020ac85748000000b0042a43923119mr1425062qtx.28.1705940963400;
        Mon, 22 Jan 2024 08:29:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8y2b4LU5oAzpPaMAvqlSiqTTAtdMr1TQNmzT7PfLEcqGE7IZHFmbWqG1/mm+qQtBLwTm3sA==
X-Received: by 2002:ac8:5748:0:b0:42a:4392:3119 with SMTP id 8-20020ac85748000000b0042a43923119mr1425054qtx.28.1705940963149;
        Mon, 22 Jan 2024 08:29:23 -0800 (PST)
Received: from debian (2a01cb058d23d60079fd8eadf0dd7f4f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:79fd:8ead:f0dd:7f4f])
        by smtp.gmail.com with ESMTPSA id bq17-20020a05622a1c1100b004299f302a7csm2608494qtb.23.2024.01.22.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:29:22 -0800 (PST)
Date: Mon, 22 Jan 2024 17:29:19 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/9] sock_diag: annotate data-races around
 sock_diag_handlers[family]
Message-ID: <Za6X33wpW128moVL@debian>
References: <20240122112603.3270097-1-edumazet@google.com>
 <20240122112603.3270097-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122112603.3270097-2-edumazet@google.com>

On Mon, Jan 22, 2024 at 11:25:55AM +0000, Eric Dumazet wrote:
> __sock_diag_cmd() and sock_diag_bind() read sock_diag_handlers[family]
> without a lock held.
> 
> Use READ_ONCE()/WRITE_ONCE() annotations to avoid potential issues.
> 
> Fixes: 8ef874bfc729 ("sock_diag: Move the sock_ code to net/core/")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Guillaume Nault <gnault@redhat.com>


