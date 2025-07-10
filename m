Return-Path: <netdev+bounces-205734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79DAFFEB5
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 12:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43731C80D78
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2A32D5431;
	Thu, 10 Jul 2025 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Siz47PcT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C02BEFEC
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141969; cv=none; b=mUC0Ii8xZ/1JTYFezibHvGwBN3x4i6pzhpoj+R8VPjffg7F4MDRuvvH3VBXcDNUZLfU/hxSSGcsOEZSi3Mh0aK2zLCk3ugQ8p5xP19oA6dRM5gpipfTvA0a5IGPQxeTWntf6UdU9aglndk4FJU4UXgsyYT+Bnwo0z/3XT4kc4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141969; c=relaxed/simple;
	bh=Cw+Ab7HpksJJM3sUjtbQodxLYkrBNrgmWBgDP6g9SiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3p1TDM+6Tn1WBhNFRO02OmJNdGJ1l7NHrC7xYt/QeoZCUiJwGSLQsTC66KAS9yRIfRHjO2mv0e8Fa0XxNFZkYbFiX22K71afn2/eN8oyj6Ra8KFyKyRzO81CGZ7542kqoss9U7nSv7XEDa/iwCHbY6cOImoNh2vJWK+pgj4IK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Siz47PcT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234fcadde3eso10910525ad.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752141967; x=1752746767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ4jsVOEwRBTCMQKr+gzhAsfIDI0NCJZUfsAQDyIHCA=;
        b=Siz47PcTth+Xk/p0nLk+9zPWJyLB26vBn9Yys3Gu6l6ig6Rsm/m6lVzEJa0nHwUcTk
         uNIaV1Gw0pdVn2JFg/R8oinfQ/S5cGS0ToO1KzOrLYamIgozzgcJ0ff9t+uA8Kw2Prj1
         0hbAvqgjPmq3VJydvK3I60wse49/QmL+xa8G4NaKtQ9/rVivYyZwrmWd+ppGH82vEque
         BBg+u1PQUK0J0pk1t0BqCjCnpUhLJAO/P7cfw0PsKbJUo6CLOAMvt7j5jsEa+8ZmopGz
         +KdldKXt5PUAM3ZDhF4DsGaWcOQCKBXsGfoeeHRewjxBVI3rYObbW3gJr3ys4bCBWKcS
         JG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752141967; x=1752746767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ4jsVOEwRBTCMQKr+gzhAsfIDI0NCJZUfsAQDyIHCA=;
        b=dogE+ILTImrEJjFTSn8veA858orUtKP+6ewJFwv4udUymUCL0LbL7B+f4xcLjUhbUs
         Rs1ry5YPYaHAwIfkLKOYOyFWKCeMJxhTyxjdYgrh6pkSlyF+HmIBVnVEhjBD+ekYxlMM
         9J3Hl6811+AFlYHO+1fcEsUjqnT4PclBov14IKQ8+NSgMObS5vVKx1kAQV+pvNCu/EbI
         svzq/lh2DaMzUEoHpzwidRplG3FSi/WiS6GFl35F6b2SQ70ChM9zTdGPu9Tgjw2XQ15g
         6AeBo9ogRFjCWHycIAUBA2rQlU4mHXs46umhUAdy47kin8a5YaZSKUR5ZHvcsb9KKA8m
         6UrA==
X-Forwarded-Encrypted: i=1; AJvYcCUc0Qu+xfjw8seYud6W+kW6M2dhkpB1MTkwrsHHiUH7/kw3RVWrsEqw+s2Zfcs/cfmUgtAF/MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxndyR8SxAJNjOtDjMEJkBPM1ZE1w1beG6z1LUI4wRIbMDSNvrl
	hWQ5SSvmDWc45Wji5oIrL7+iNfctzLheDe6MKE1fYStqCWIbVdXOLGbWgUSJhsohLg==
X-Gm-Gg: ASbGncsI9fY6ev6RNmxnG6/fnypznsqlSjGwiIBpbZBwmtOcJ2FZWZgD4I1R1uUocyS
	yqLirIsp5HG+yPSO92Re/yMdx3bvZR0FIUD0c9YCzowylqs6XfqDN0YuveSYqHlsZQRDplXoaOp
	fjLxOZWklaPDss3hZOzdsQrpjm8a9GtxB2nuSSIcFA5LPNZGVFmWgOYbPVnVAMv9DWNKNmtxtm0
	zFo5RZzKAzuP3EYtExiUmfWsS75aDIszBI2rbEuDDMz3OR2NnLoql+Ux9l4RDe8Z6kQ3sDs7+hb
	1AAPtQ7tl9wfn5CcdSxoj8KZJK1fnzkK3eHLJhrb1fI9lVdgiaNrdhaltOAXe4XIH+dgb++B
X-Google-Smtp-Source: AGHT+IHtzn36TW6Jc9sgdPfbpNLanNr5irWhlnDPftSTcOsu6ZjCP8VA7xq+UNlJ73driSYbsp9haQ==
X-Received: by 2002:a17:903:8d0:b0:235:1b91:9079 with SMTP id d9443c01a7336-23de4865608mr34663345ad.32.1752141967595;
        Thu, 10 Jul 2025 03:06:07 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42845c7sm15900215ad.26.2025.07.10.03.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:06:07 -0700 (PDT)
Date: Thu, 10 Jul 2025 03:06:05 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Jakub Kicinski <kuba@kernel.org>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
	security@kernel.org
Subject: Re: [PATCH v2] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aG-QjXKQUHsZO5nk@xps>
References: <aGwMBj5BBRuITOlA@pop-os.localdomain>
 <20250709180622.757423-1-xmei5@asu.edu>
 <20250709131920.7ce33c83@kernel.org>
 <aG7iCRECnB3VdT_2@xps>
 <20250709145458.1440382c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709145458.1440382c@kernel.org>

On Wed, Jul 09, 2025 at 02:54:58PM -0700, Jakub Kicinski wrote:
> On Wed, 9 Jul 2025 14:41:29 -0700 Xiang Mei wrote:
> > On Wed, Jul 09, 2025 at 01:19:20PM -0700, Jakub Kicinski wrote:
> > > On Wed,  9 Jul 2025 11:06:22 -0700 Xiang Mei wrote:  
> > > > Reported-by: Xiang Mei <xmei5@asu.edu>
> > > > Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> > > > Signed-off-by: Xiang Mei <xmei5@asu.edu>  
> > > 
> > > Reported-by is for cases where the bug is reported by someone else than  
> > 
> > This bug's fixing is a little special since I am both the person who reported 
> > it and the patch author. I may need a "Reported-by" tag mentioning me since I 
> > exploited this bug in Google's bug bounty program (kerneCTF) and they will 
> > verify the Reported-by tag to make sure I am the person found the bug.
> 
> I'd be surprised if Google folks didn't understand kernel tags.
> Please drop the tag and if you have any trouble you can refer
> them to this thread (or ping me).
Thanks for the endorsments. I'll remove the Reported-by tag.

