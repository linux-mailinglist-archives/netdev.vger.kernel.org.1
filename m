Return-Path: <netdev+bounces-64885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773DF837587
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F68228B887
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1C7481AB;
	Mon, 22 Jan 2024 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyfmRzpB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE3247F76
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959511; cv=none; b=W0ml5AquIVh2PMN1cYGBeBioU9kPnM7kFwsKUoMuytnIQJCpePkXewNiZXpjrUSFYrCpWcLsWTYOdnrynL0GydWrVJc1WeU6DQ2D/yGeuMSzdEWIe3q2lznnpP9Yt9nuAPLo8MIE9cGVh3YwzK59LtUphKYQ/BhUA3pTwkOnnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959511; c=relaxed/simple;
	bh=LElJRWqt34x+8DF0FeM4c2fsFFCAvlampCWtlrAj2Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB7JgZ5zrjJgk2QZFau9ET5vmtxhLZTNzwyvteo4fhYVRo3QURgP/aM04wnde2VSHhwsF+NOEsJTAlSaYBxVQMU40pSzavNZNkLsfavlvgtlxyiXywvXa5jw66GbjkxSrVJ708ePP5XIycjSwBUqw2+ikZvrBnYilsu3+fYy+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyfmRzpB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705959508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x+M3YT9/M/9hk5KKjg2Z2GsTgbaFoNaiIwpBp50I9ic=;
	b=VyfmRzpBeQmCZgiYTleS58hv83VLWc/u01MBTHPqCcAEq79mobeVDAX+78a/lGnAbG/AFi
	WiH9HgQ+bpk8138Emz2Dw9mQ033d19jmQ1QvpiFH8TESwlP73Ams3At9ZEFf3HdOynoiY9
	5LsFxSfB7Os7teh7piyRkcNEuYuV198=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-gr_PWpdNOIGnb9fupwkqvA-1; Mon, 22 Jan 2024 16:38:27 -0500
X-MC-Unique: gr_PWpdNOIGnb9fupwkqvA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-337bf78ef28so1521380f8f.3
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 13:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959506; x=1706564306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+M3YT9/M/9hk5KKjg2Z2GsTgbaFoNaiIwpBp50I9ic=;
        b=lAviLQjsK6iZO1NF7VeBzOEtC6ojtLKiAoiQfBxyKc86WTqVloJz7NZEX+OjH5fq4q
         Phxd1r2jAQKixmDVvS48efFajoK9J8SgfidJHV2c3V/VdbgyY48y1VbiFk4X8yYT69HP
         +eZvI48sBM7+jxb2sKyJdxqtfNoj1lKrUB8ZeUM7aMBz3XPuTJYXrGHybu55hyMXOSUz
         ohXQ8mx8Ymj0Dp9uWJSZ4usuMXMJFC+Gf/w5Op7Ew5guoLi+N2u8lRrj2MZOD5SFdn5X
         rghMyY/HziLlx9Q8YFclMt341MTB+Oum5ScePkFgBBMpAkY9pRFsZwhn3PXvHZ9JS+qW
         AlVg==
X-Gm-Message-State: AOJu0YwrZAriAGS8DxcZoskMqFExztCZqm5sVEmWPoy2ds4GhVbzD4TC
	MHLJbSNIquupSvdelAD3NmsovdH1wmaBP1qIN1oNcAyEs4qxwGM+xzmX7+WpwJbujP9Nx+cCrVd
	PYJPW8meyqvCQvDEOqc/MMJ4uMvKFkGP5mAYuYaTIWGs/7UEfYcqxeA==
X-Received: by 2002:adf:e38c:0:b0:339:359c:3d3e with SMTP id e12-20020adfe38c000000b00339359c3d3emr1524463wrm.56.1705959501506;
        Mon, 22 Jan 2024 13:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+K10WxYolRtPEs7r9fj2IUc8a1PzK95Gn2nlCsCxpjDYMpScEiCqN4Bu20eT/xkfVfzOYhQ==
X-Received: by 2002:adf:e38c:0:b0:339:359c:3d3e with SMTP id e12-20020adfe38c000000b00339359c3d3emr1524453wrm.56.1705959501168;
        Mon, 22 Jan 2024 13:38:21 -0800 (PST)
Received: from debian (2a01cb058d23d6005fec131dfc58016b.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:5fec:131d:fc58:16b])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6507000000b003392940f749sm7095292wru.77.2024.01.22.13.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:38:20 -0800 (PST)
Date: Mon, 22 Jan 2024 22:38:18 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 8/9] sock_diag: remove sock_diag_mutex
Message-ID: <Za7gSsHOFzT1T0h1@debian>
References: <20240122112603.3270097-1-edumazet@google.com>
 <20240122112603.3270097-9-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122112603.3270097-9-edumazet@google.com>

On Mon, Jan 22, 2024 at 11:26:02AM +0000, Eric Dumazet wrote:
> sock_diag_rcv() is still serializing its operations using
> a mutex, for no good reason.
> 
> This came with commit 0a9c73014415 ("[INET_DIAG]: Fix oops
> in netlink_rcv_skb"), but the root cause has been fixed
> with commit cd40b7d3983c ("[NET]: make netlink user -> kernel
> interface synchronious")
> 
> Remove this mutex to let multiple threads run concurrently.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Guillaume Nault <gnault@redhat.com>


