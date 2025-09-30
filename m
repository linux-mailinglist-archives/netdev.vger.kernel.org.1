Return-Path: <netdev+bounces-227361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099B1BAD19C
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 15:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF81172F9E
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D951F0E24;
	Tue, 30 Sep 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHUio128"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259F1E0DFE
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240055; cv=none; b=sFebpyPYVe84JrJzsYz9EKW0pI9OHCDoKqod1rDexDrJMo9QRyVxL0AWV2HvfgX/jKpPXVM0A07Z74B6ecsJ9roQhLKgZaAk5hqWCbAto+qwuNde/3SrkkZpJXijqdtqyuzWt8mkfIZA4PTH7iPfRVgWpoVcFYCI4NAqA+53qLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240055; c=relaxed/simple;
	bh=djWJ3WSoFOE7AAiVgSgO9kaO15CNySawak1vG1iZbXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QabpBYcxZtqNOMHd5iCv2ruRa/2t5Y1w9gLGjSFVMYclqceEtOvyddec/NTwpWVrpQG55MMEylg3YkP02vGD5moq+WlYTJlxk7Yv4jMu/iiCrl5tZq+Jt4iug+m27YYYebyYB1m+q7QeglFFFYp1Ij9vtgVpF94MkC0BPW2NqeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHUio128; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-267facf9b58so43802575ad.2
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759240053; x=1759844853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jMdofcUVGSrS6vDNWwFHz9+M//WqgG/7b80iTTRoas=;
        b=SHUio128k4MsO7mMYdmR73ahK2lbAeQy2BHje44Q+2yqb1I/TCEh82WJd3R6ZpnSRI
         AO+D+Lc9O6OnedZuLnAyn4+QSHtkDz/8nyJgEGrVN7VLqMM21cVqJGbqDIeYX0No9upA
         XhjIyL7INFwK3qE0sAXP3EfIA0fopYJ1WrXzY6g7NByGb8DI6wVxIxBGpcY+l3bPtG0a
         HAP7aj9XtA1C9X3ThZ/cNWoyhUeSoQiRNEoXAjqpfnyDuacJucsyTSRkyMFurxpcjFub
         OaYjifuHBLI/Fh66m91isRKkp6VSc+XpQexOBRjVMHOe0yFP4TizK2uJXaI/vhd9RA0L
         iPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240053; x=1759844853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jMdofcUVGSrS6vDNWwFHz9+M//WqgG/7b80iTTRoas=;
        b=B/WAJlk0SZh/LnHtOoyUec2pbA0lMjEW35hWJiCMaM6IXNEL65e4ueX7RI6+kac1m1
         NvKvwds/FKW8epAkJHDb6bBO/2Ctv20aO9tb9+kTaed5MmoGam+F/f+WelbKZXufV36r
         GyNdX/9op3M4PZ/RuNAo/rOOGl2rcP0J8CKebq8pcAodRwkbEOBTFMHj5fdz6MSl0GoW
         akw1kLYWT59BurdGRkW08WrMgV/O0cLoZBIKllSnbkGGPVIg6ZIPNq6H+YbxFi+Wa6XI
         HzTyu3+ijdixGJECTyNZLfdfZ0gZJwXC83vC1GXLIYY0DDob7SzpDvSVzF99XQdNg4z9
         uE1w==
X-Forwarded-Encrypted: i=1; AJvYcCW6OIq2A8ByCHnEFVZhg+2r71yi5D25kLQ70VQIJBUs7zEeSG78EEupNTDm1dA3Tbqlfv8AYRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzBEb8REtOjWMRgGzPCjQJ3ColhZpWUK1awpbV7y1HbLRvdXLm
	ySRK+7I0nCFDK1Ly55w/btZPCQCtiGZt0kssCS/Vx2eTpecqDjoUWb7G
X-Gm-Gg: ASbGncsBaGKrEdj/azSluJSJ/5hrqcE8ImgYRi+4ZCNUbI3gDNeeQzMDbr7XU9NLdgG
	xGwy4C9PyL5x1QmTDcsgeCp9lcX5w2NZ8x44d10evT/nnRLNUmVgrmE0bH16LnF8du+fB2Vor7m
	deiFZ+H2jbyvAw4IhJkR65o+5hriq2TPm4XBHP2ijkdfrpq7azggYcKBxYmZw58d5vw0ZSsWf+i
	tGlyTkcyvwtPjQrN9uboparJFpe4iGiuYzEvqkiJbcsYnRIpu1vF6nEASbdFIKIbp62kYoE4vEE
	bzltwivNQ1vaWMHQsJc0MyktJ+IvJ48gGviyPHyqOC8W7Gi7i6/xXTw1LGWbgo5YPbl80+UWD9P
	PdUOUK/rdqf61Zasj8bqcARWkmJFcCeRSdT4ytBPIAAp2c2/k50/XhqFUwvsC
X-Google-Smtp-Source: AGHT+IESYq35TAQFLeBWF4OxglXdXWfZV95e+sPc0Kl6L4WvW4KjgdJME1j4/hRI2m+l8euIgk7tPg==
X-Received: by 2002:a17:902:f650:b0:24e:81d2:cfda with SMTP id d9443c01a7336-27ed4946b7bmr211097935ad.0.1759240052489;
        Tue, 30 Sep 2025 06:47:32 -0700 (PDT)
Received: from localhost ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-281fd60835bsm99535715ad.19.2025.09.30.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:47:31 -0700 (PDT)
Date: Tue, 30 Sep 2025 19:17:29 +0530
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] selftests/net: add tcp_port_share to .gitignore
Message-ID: <nebdn6xrcevewtcv6hbumf5tdh4p4patujhdojc7hn2yppwil6@jqbfz7q2ljth>
References: <20250929163140.122383-1-krishnagopi487@gmail.com>
 <aNucABvb0PvBtCxr@horms.kernel.org>
 <aNuci8Y9ZO9pd0Ua@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNuci8Y9ZO9pd0Ua@horms.kernel.org>

On Tue, Sep 30, 2025 at 10:02:03AM +0100, Simon Horman wrote:

> On Tue, Sep 30, 2025 at 09:59:44AM +0100, Simon Horman wrote:
> > On Mon, Sep 29, 2025 at 10:01:38PM +0530, Gopi Krishna Menon wrote:
> > > Add the tcp_port_share test binary to .gitignore to avoid
> > > accidentally staging the build artifact.
> > > 
> > > Fixes: 8a8241cdaa34 ("selftests/net: Test tcp port reuse after unbinding
> > > a socket")
> > 
> > I'm not entirely sure this qualifies for a fixes tag.
> > It is user-visible. It's probably annoying.
> > But I'm not sure it's a bug.

Hi Simon, thanks for the review. I also feel that Fixes tag is not
required for this change. I added it based on this earlier
commit(7ae495a537d1):
https://lore.kernel.org/all/20250307031356.368350-1-willemdebruijn.kernel@gmail.com
but other commits similar in nature dont have the fixes tag, therefore I
will remove it in v2. 

> 
> Also, FTR, fixes tag's shouldn't be line wrapped.
> 
> > > Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> > > ---
> > >  tools/testing/selftests/net/.gitignore | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > I notice that tools/testing/selftests/kexec/test_kexec_jump
> > is in a similar state. Do you plan to send a patch to address
> > that too?
> > 
> > ..

This has been already addressed and will be in 6.18-rc1 I believe:
https://lore.kernel.org/all/faf206d8-ccd8-48b5-8e7e-d596ddbbcbb6@linuxfoundation.org/

> 
> Please note that net-next is now closed.
> 
> So if you do respin, please wait for it to re-open once v6.18-rc1 has been
> released. About two weeks from now.
Noted, I will send a v2 for this patch when net-next will be reopened.

