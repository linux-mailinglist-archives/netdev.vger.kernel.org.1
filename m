Return-Path: <netdev+bounces-137639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1509A91AF
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 22:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD561C21A44
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B1F1FE114;
	Mon, 21 Oct 2024 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tDPNlaY8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650F1C461F
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544314; cv=none; b=fuofqGk85WP9zOcAPewrWk51uz0rILlB64rFp5WW99qrThbwxJ21cidoMaAfJooJSpOWT1L42TaP+l8vDv+XXs/rc0G/vQ51622urX6RKotTmg76rLO9qvpbCCmfrZfwtHWN7GUaYsDRtw5KGoDTqNW9kHgyP8JJSw/BLvaoYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544314; c=relaxed/simple;
	bh=LAnIgS1NKQYz/pvj/a5RvqS4hMAmNIzXS0zSl9089WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly+RvwS6vd+LLXVL6PG6Rw3HOU6Di070ynsHPe+0Ni6InOdw/6b/AxSx9qHN0qxSry2EyqpO2Q592/hwoC7YKo6fzq7W4GoatC7pxST4ah3lU11iMi3kRhvTDrzC/eGe0tuekonzMfG9KfCSg97tCW4d/nW0f1sY5iUEO7vHacE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tDPNlaY8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ca1b6a80aso45819255ad.2
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 13:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729544312; x=1730149112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URrrdZa4BMR5AmfiFrR6n2gYgJdlFBvT4K+/Velpyh8=;
        b=tDPNlaY8SZW6KSEoDdu6ibc7PZwQGyBGjk8dUpjpuTq8sTqqk2Jk+m/XgplFEWYjBH
         KQBKM8REPZVIhCGZLjsQXNetYCDp16/t3ShQqoREdw95pO4NC5A2xzNanyyhrJQySjaF
         NYFHkEKQS3RBjIx/Ha9LWxgZa4uKTa4A3eGzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729544312; x=1730149112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URrrdZa4BMR5AmfiFrR6n2gYgJdlFBvT4K+/Velpyh8=;
        b=xA3qwYzPiDWEeBwGLZcZSJbk1T1mbnLdzIvoDuOFeG1McOgp98xY9Dd35PD9fembXQ
         jQbRnBnW7hgW5LDappgqbmgO7rXNJk4qWtDaCesyeYLmTz9ejX8iJfNu/Jt3jZ4wyn+m
         GPaFgsM2A+IIbdAQkqvqjpZs4u4MD/z4Rm5s070/I3a84gap/W8clhSnDXM47fCc0l9G
         yX1ijLsjT6KZbn0tw75dSxEpGci5rEgeKQj2tmdTJY6q0h1+Oj/juSoqbdqEodFwteb4
         V4qSCMQwB4bUtxu/XYsBrXbbLgpOh/PqJJ/+af2IZxLHvaCqoM883LseEu2z1DIlr1EG
         gRZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvVvsdt2e3gVrNxJporw+V8cWqJH5nUg3ShSlCmqaM4QzlBZdWZF03+91yorSOskhlWDNMfXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzDi+gNoHzOZQrEG9ooJYH2II8kH7MrEmhTK3wHoIQSub+Vla
	6nfix9Fck7sdkXyjJoVEG4XKmyZsvGV84zMZ/m8ej9F1AqkovN6EJbdPQ8gQ8ns=
X-Google-Smtp-Source: AGHT+IGNGRamrT9Yk5Y8YH2RpgMRrRgNN/GmWlJMpJC0fGspj+szfIkAqmgn0lLkBMUoYFkLbNJukQ==
X-Received: by 2002:a17:903:22c3:b0:20c:7d75:bd5b with SMTP id d9443c01a7336-20e5a921b20mr179921105ad.42.1729544311794;
        Mon, 21 Oct 2024 13:58:31 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f3c95sm30063545ad.253.2024.10.21.13.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:58:31 -0700 (PDT)
Date: Mon, 21 Oct 2024 13:58:29 -0700
From: Joe Damato <jdamato@fastly.com>
To: David Ahern <dsahern@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: yaml gen NL families support in iproute2?
Message-ID: <ZxbAdVsf5UxbZ6Jp@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
 <61184cdf-6afc-4b9b-a3d2-b5f8478e3cbb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61184cdf-6afc-4b9b-a3d2-b5f8478e3cbb@kernel.org>

On Thu, Oct 17, 2024 at 12:36:47PM -0600, David Ahern wrote:
> On 10/17/24 11:41 AM, Paolo Abeni wrote:
> > Hi all,
> > 
> > please allow me to [re?]start this conversation.
> > 
> > I think it would be very useful to bring yaml gennl families support in
> > iproute2, so that end-users/admins could consolidated
> > administration/setup in a single tool - as opposed to current status
> > where something is only doable with iproute2 and something with the
> > yml-cli tool bundled in the kernel sources.
> > 
> > Code wise it could be implemented extending a bit the auto-generated
> > code generation to provide even text/argument to NL parsing, so that the
> > iproute-specific glue (and maintenance effort) could be minimal.
> > 
> > WDYT?
> > 
> 
> I would like to see the yaml files integrated into iproute2, but I have
> not had time to look into doing it.

I agree with David, but likewise have not had time to look into it.

It would be nice to use one tool instead of a combination of
multiple tools, if that were at all possible.

