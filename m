Return-Path: <netdev+bounces-134595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5199A4DD
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1184B240AF
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9812185BB;
	Fri, 11 Oct 2024 13:19:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC920CCE6;
	Fri, 11 Oct 2024 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652770; cv=none; b=e70IVuq/tzhYJWRBTYPWXEtiXW2iihpUU4JGAZC84OlEmrA1h82+wHKbie+HYIbp3NmCPXxndvpG6JIAuZVf/Mybu0QQM0aTxuktRpPWffAUhsaPH66wdjNdMZkg24ufC7ALyoSHZ3Iz1YBBj3VMuFLqkDyO2/d+aSX7z8QLf7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652770; c=relaxed/simple;
	bh=cnJ5uvSVuxAfXsetBrggN16fMsTSu79tuyp1x9SGquE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWILgiDDHOtOgZvhZAGt3GhSHLoDUdwLBPd8aT/6QlU+GaRbVu52Fu9P246vgSgLk4XE9TuRYcaUQiK+kcnl3DcKkdQe0FPk7blJE9nhIRiVtbCTlq6NoNtOJIzk9zf6/x3SKMH/YL46GhwPJbzIa++iiqlMlHqtVMnU8WvLeEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d47b38336so1155291f8f.3;
        Fri, 11 Oct 2024 06:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652767; x=1729257567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfPQ3c0xR8XvTs1ww54hU922OvwjE1r+ePXVHUoyZs8=;
        b=b3o+KpGkEhswSbHel4dR/UNMM+C/Vhkc7R7FdC9SAXODJ83xTRH6nGOIRv/gKzQba8
         03K7hWWucO4GsE//UJGheuRnyWc6lwpT5cL8JpK/S6IIKHu/OTt5oH59dCi/Hn6i+icp
         SKtDfK2PKRILcgNgiq39zCjMiP0fYH4IYtKBFe5yMvh3c/wQW3Ko3WnrS9nSvnNiAHho
         thiP+UamJ2LeJLZRLZ3pOtA6hEJ3g1guNBe7wvOCZvgHhXXzn1AF2UDiUYfDM2ugDBRy
         wq8XupFknbetx60bW7YK+024wJ0d1qLpY9x6mOG4SwMvGGDt4Xdd8aEmmzzrDOlZTcfa
         lQkA==
X-Forwarded-Encrypted: i=1; AJvYcCURUgSupJDq1EHxk1XUvmVwacW9cP1TCuzS5VtF9SdexHvqa51J/QJ93GHYX30xzWL8wiQU8nQF8v7mBAIy@vger.kernel.org, AJvYcCWFI+v42bdMkZ2mOxljAu+J0ZlqQxIlOO1yR1IJ6cIHS/Eg7L5OXBMtz7/ji+fnn8c5IhCvp0OwzQM=@vger.kernel.org, AJvYcCXFAW7srt9e4sgeBMCc0/9Cf5uRmu1GV3fAmAlUYfcz5grE8lwg7eVpJU2ftGz7zQwX0kdYCVOe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0AptBqGiLXUHjgTUyHv8j/7Bxu6Wh+uEBAg4WEXnQLFj/gx8g
	6jnryTPbMaMiLmqeOV1Fl44yBfGGDAohtkRnkK7DRC+TIagHf0Zj
X-Google-Smtp-Source: AGHT+IF1KxyNFqKfcwngVLGBbxEHxhdpVgb23EjjmLJ1skOpBKj7hUXQXCc0BHIChnU5Vc7j5k7g5w==
X-Received: by 2002:a5d:688b:0:b0:37d:462a:9bc6 with SMTP id ffacd0b85a97d-37d552fd82dmr1824232f8f.36.1728652767217;
        Fri, 11 Oct 2024 06:19:27 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cf8dbsm3936638f8f.59.2024.10.11.06.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:19:26 -0700 (PDT)
Date: Fri, 11 Oct 2024 06:19:24 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@meta.com,
	kuniyu@amazon.com, asml.silence@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: Implement fault injection forcing skb
 reallocation
Message-ID: <20241011-elegant-cobalt-bonobo-ba5aa1@leitao>
References: <20241008111358.1691157-1-leitao@debian.org>
 <822f5875-5ec0-46e1-83f8-66ec1e31f0f2@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <822f5875-5ec0-46e1-83f8-66ec1e31f0f2@redhat.com>

Hello Paolo,

On Thu, Oct 10, 2024 at 11:20:05AM +0200, Paolo Abeni wrote:
> On 10/8/24 13:13, Breno Leitao wrote:
> > +void skb_might_realloc(struct sk_buff *skb)
> > +{
> > +	struct net_device *net = skb->dev;
> > +
> > +	if (skb_realloc.filtered &&
> > +	    strncmp(net->name, skb_realloc.devname, IFNAMSIZ))
> > +		/* device name filter set, but names do not match */
> > +		return;
> > +
> > +	if (!should_fail(&skb_realloc.attr, 1))
> > +		return;
> 
> if you wraps the above 2 statement in an helper() taking an skb argument,
> you could wrap it with the ALLOW_ERROR_INJECTION() macro, for added
> flexibility, i.e. look at the existing should_failslab().

I've looked deeper and your proposal, and I liked it. It makes sense to
have it as a helper.

I will send a new version with it included.

Thanks
--breno

