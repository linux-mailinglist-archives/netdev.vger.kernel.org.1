Return-Path: <netdev+bounces-131921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4914098FF17
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6033E1C232FA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FE913E88C;
	Fri,  4 Oct 2024 08:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9583CC7;
	Fri,  4 Oct 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031821; cv=none; b=gPomLlk4l3BjQA9AHBseZTtXM3t5WpbwHMQR+D+0EhsQQvLIqvmJARN3dXXXXJsMzpFWdGIjrVj+h7l6Qz67/rAAte13Cx8sX2RC+v9qi60SBuBRK42a7XKJWZPGrnnbVBbTJtCZajcr7e+wP1X4lFo7yv/RZbxE6mAeIdV+AjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031821; c=relaxed/simple;
	bh=brs4vqq6sRMILIMCgqsqLxHJbLT4oI4ddjbsMML2hv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC5nXwzEvH9fX266Nf9oKoka74moJFD6XgiaTjyZ4ZSZpAlnySJeDEFZiILbajIWhn46U3D2uwSGWWcvDh+ioBXp54KaiuPEbCfEKTAaMsOAfSZbjvhcNvnTgLdm+ObqRy7UIzpoXNb3tzrHLnz1f6dQ9enkieAokJBdHfNgauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so219197366b.2;
        Fri, 04 Oct 2024 01:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728031816; x=1728636616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWXRQmEKRUvy5dgKeAzhc5Es4XWK6fmdYFao9+KG9yU=;
        b=BTuCepT+XkgH9lxZM9TSfq0YPYIpD1FkMIK2htGNQuAfNZ+0l1EMRkufFQPaV25SiX
         WxBe4kVFSLgF3qflGYNvyogSHrqMrb6YSXecQh+0ijKkbHqnsbS8ZQ2maBzqWefzfjGQ
         kjcGIKRaiahly0LyKdVOwudpnc7XsfHjYTQmQkrnNE/468oHJdCe3c/nsL3p9Gb4+yWq
         iER0wucc3FyyECHBqIkYU9ZojEFS6juHBrqZNfclL6O80RMpzITh/Ap1BFD5CVTeDh3u
         kFC3xxpKK4ZFYYq+yL2UmYNreFwhPCPboYq5X4FHXKRmvQWneTY/9SCBDs10IE6t9aXZ
         ZfWw==
X-Forwarded-Encrypted: i=1; AJvYcCVnUIn5hDQeAr2vvjEVy3VHHlORu6y3YJ+oUS6G31Pgkm8E2OA2Ja9KIH82x6AdWiy2BaNIdDyIPCkAPms=@vger.kernel.org, AJvYcCXKxV6T5QxWUcQq1P0VzK7F+Jkq7kHkzfE5yBak/EZxFHteIeQz2FK2rGAIef/p2yFstqfr1I8O@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyB2dub0u0EkcPzc4f9nzwafTSjwL9/PrjJcfRjlFzU7tu4j+
	G5rsVCwRGpSQpRz7ZYTaDrEJ4ZEf5W7Hw9IsfPmsv6lBguuq/ueojZtpzw==
X-Google-Smtp-Source: AGHT+IFwzBq3saaXD1U+2e/sY1NQEztIfJ13LQ3zyQ84huUNUhpo++ZSsCD+X0SqjVx2fiyZ/FY0aA==
X-Received: by 2002:a17:907:d58c:b0:a86:b38d:d703 with SMTP id a640c23a62f3a-a991bfe017cmr167982966b.50.1728031815915;
        Fri, 04 Oct 2024 01:50:15 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99103b5016sm192766866b.119.2024.10.04.01.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:50:15 -0700 (PDT)
Date: Fri, 4 Oct 2024 01:50:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	thepacketgeek@gmail.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	max@kutsevol.com
Subject: Re: [PATCH net-next v4 00/10] net: netconsole refactoring and
 warning fix
Message-ID: <20241004-shaggy-spectacular-moose-1b3bd6@leitao>
References: <20240930131214.3771313-1-leitao@debian.org>
 <20241003172950.65f507b8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003172950.65f507b8@kernel.org>

On Thu, Oct 03, 2024 at 05:29:50PM -0700, Jakub Kicinski wrote:
> On Mon, 30 Sep 2024 06:11:59 -0700 Breno Leitao wrote:
> > To address these issues, the following steps were taken:
> > 
> >  * Breaking down write_ext_msg() into smaller functions with clear scopes
> >  * Improving readability and reasoning about the code
> >  * Simplifying and clarifying naming conventions
> > 
> > Warning Fix
> > -----------
> > 
> > The warning occurred when there was insufficient buffer space to append
> > userdata. While this scenario is acceptable (as userdata can be sent in a
> > separate packet later), the kernel was incorrectly raising a warning.  A
> > one-line fix has been implemented to resolve this issue.
> > 
> > A self-test was developed to write messages of every possible length
> > This test will be submitted in a separate patchset
> 
> Makes sense in general, but why isn't the fix sent to net first, 
> and then once the trees converge (follow Thursday) we can apply 
> the refactoring and improvements on top?
> 
> The false positive warning went into 6.9 if I'm checking correctly.

Correct. I probably should have separated the fix from the refactor.

For context, I was pursuing the warning, and the code was hard to read,
so, I was refactoring the code while narrowing down the warning.

But you are correct, the warning is in 6.9+ kernels. But, keep in mind
that the warning is very hard to trigger, basically the length of userdata
and the message needs to be certain size to trigger it.

