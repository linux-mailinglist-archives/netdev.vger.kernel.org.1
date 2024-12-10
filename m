Return-Path: <netdev+bounces-150523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857AD9EA863
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E0D16B0D2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 06:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B4F228365;
	Tue, 10 Dec 2024 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhAAMJlc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A28227576;
	Tue, 10 Dec 2024 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810301; cv=none; b=f7YTOC8/Awp9uPPsmX5XhXTfE3aT1mNZTW+lN+pfFQwF+nQNDZgYSm9+ZuH4bypm+Forb+Oey/dyoRFZ3THzwMABinTjvgkYaqib7tgF8VCLhuPl7xqikUDBdaxXFgURzb7XOOh7345QjMugYbxYI5mDo3IoYk3BDQYH0FnUD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810301; c=relaxed/simple;
	bh=FFXVBYJdceyl4XT0A8yG4cQzC+NG2x5Az0mC/e7hfiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3WkaqHCTtsIwQ2kSahhFpQ/s9idyYb9i/3vVawM5Swv/gw0gHkRmVHgsmcA3CCw/og4UORKC09/cFYUi8gOksE7di6gvdn+9E2bWEYvX68HFZSriheIIhN8uFWq3kJMBhL1ttvUhR7rXs5wDOcY/1gQHVGrttz4d//2vr0KQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhAAMJlc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso3680180a12.1;
        Mon, 09 Dec 2024 21:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733810298; x=1734415098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c13hr8cDiby2OUqrKBsb+Aw3JndZ0NAXgGNUdqb3LWs=;
        b=UhAAMJlcyzujaOHAmCoOWCLMBkdl/48ejCx2ychaH6bR/mmfDPFF0F+i4WntimQMTk
         Qjor4aPhamNLog5p69WuPRqJFl3odLNxY3U+SPRIN1mAwVUtsbdW2Ou2j9u5bdBqlaEp
         RLBPjmS9wZmRflVmt+5XTclb6dDi1HVaVsWofuBLgOjo+mAF03QwNMvvvjlEwYzxAunk
         +v1h+h9C5PygGwsGgtCXwqSwZgXaVrrNe3uDbOvniBGEXI6LGJgQ/QE0nmeX10OVJ2NF
         3DAt/8Y2oTv9pKXmcfZUNDhuR5tZZ49XX7liPW5FBZOjc1lcj+kfyFzOC8STy7+qqhpW
         5fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733810298; x=1734415098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c13hr8cDiby2OUqrKBsb+Aw3JndZ0NAXgGNUdqb3LWs=;
        b=Nfi9RM0qglYt8bQGmv8kTyXCUhsIOzi7yHxpIaH3sYNM3Xfm/NfpfWrh85VKnzqOpB
         KTNyIUNE3hAwuSDmn6QPZXluauNqX03NjjnY2wnJUin+HRg8CAx7WAWSAQJrAznS3rsO
         IMIA38UKABm3aXdmr0Oj6DBpSLgPuQ6WrLfFDDui4wk7/OLXo90znpTyXNpQpcmCc9vv
         LYT1Ggm4i/hRVY/QHhffW5YeBS3uDjyIFXDJpoJ2G+LPMkcULJhDlqKNbi7xRw8OyTeN
         O8XzM2wBGMipR7Rjm/1O1Rs+0+DIRp9jYtxyxFEL29/2IVKDEX2a8giZJOjNpgDYJSNq
         k8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUL+efWwGxGGXVUPHBnY2KujVrAXHC+83LcE7/A6sXymnfqWA1KR6DQ/TI6hOTEIzrY7HosvYFXdSPpafu8wxI=@vger.kernel.org, AJvYcCURNeoHPXpFLEp3hGYnu04XoVtcAl0a3/uQ4ZUvlb7Ydnm57Q7XVnyGoOOM3jICm8TmY3uCamP4@vger.kernel.org, AJvYcCXrUX9wC9lnoWt3/uYt9pzGCkjSPXfE4bw+OIuVTJpUg+zo3GTmz9g//tMAfVZu+B0AvBMO27ZpflcPQZVU@vger.kernel.org
X-Gm-Message-State: AOJu0YwGGAimpE0dLdjrylHQhvQW7i8NyZWMSmY45nqp+unrEGxR8fAB
	djgUKnJE02Wu2ytvvupO8yNm+R0+MRjJPBO5NtAYjBad2J6nB7Qt
X-Gm-Gg: ASbGncvtsPPY6Lca+1yqzxPfR+qwwIOZSiiAIrOOs+uMLMpUToVsWsn3Xbxus5QLIJc
	o9lrmL0N1rlVSeNgN88mzPCcWZ5FbiDHz6Htl7Wyh9lJ5/sBjyQdSlR08a5fbm3asAqS1Y3hSlM
	dPoS5mP/3sfWpAUAhW79AM2dvBpXtQf6UC/vYafJajYtaGljficitNy/ezBPc5xZeInQuTMKseR
	kGTElI3kJZzcEXsYQYpWOe2VOPKQnXqaddMPoT+ZJIZ+ckJfbJNcze3gQ35
X-Google-Smtp-Source: AGHT+IGi4J+lvmvQVOJpJ4QT4Ze6h620B0Rx0MJXkkLaEbe+eKB1OmlGh/vHHZqHLfYCF7cgO5psTg==
X-Received: by 2002:a05:6a20:841d:b0:1e1:ade5:c5b0 with SMTP id adf61e73a8af0-1e1b43c24d1mr3693624637.2.1733810298159;
        Mon, 09 Dec 2024 21:58:18 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:5939:82cc:e9ac:c4c3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd3fb02955sm4492227a12.81.2024.12.09.21.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 21:58:17 -0800 (PST)
Date: Mon, 9 Dec 2024 21:58:16 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cong Wang <cong.wang@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] rtnetlink: fix error code in rtnl_newlink()
Message-ID: <Z1fYeNSdnyJniJSo@pop-os.localdomain>
References: <a2d20cd4-387a-4475-887c-bb7d0e88e25a@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2d20cd4-387a-4475-887c-bb7d0e88e25a@stanley.mountain>

On Fri, Dec 06, 2024 at 03:32:52PM +0300, Dan Carpenter wrote:
> If rtnl_get_peer_net() fails, then propagate the error code.  Don't
> return success.
> 
> Fixes: 48327566769a ("rtnetlink: fix double call of rtnl_link_get_net_ifla()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Oops, how could I miss this even when I mentioned propagation in my commit
message... :-/

Thanks for catching it quickly!

