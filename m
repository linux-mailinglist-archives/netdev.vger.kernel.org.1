Return-Path: <netdev+bounces-68186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890F484608E
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 20:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB171F27872
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DEF85262;
	Thu,  1 Feb 2024 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JP6v2dHe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459184FD3
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814113; cv=none; b=IdZMbUYuA/4NxJNN4c/mxUjF1v+NVYDtAmqNk+c3iiwhZCZHL3sz3wxVYknf2gkmqjx3OIqXckery7lDQR//pbbLnK/+7Fi5+1qGZCvf/N6nDp5U4aivYcb3Hud97nRw+TNXXtfPxavdxdV1t0/bGPprdiIpzJUXmBiMrciSRXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814113; c=relaxed/simple;
	bh=pmt9hG2QGZL/zqHnnAhqZNv520tGKDaKr2CFiXadY88=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptKYPPCrCKwsG4PKpadxIjXDqZnRxQLzcNfENCEb4Hda4UnmjPc96oI3BmEQv9kKmYDlT7CptmGsqT0ReRghjq0RjIQJ/Fy1QZqpzxIobLKOwP+E9GDZYa5EB7/Sq8fCs2raV2l9adfk29lNK/2QawGLdyxe4PMLllMlVMrI1EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JP6v2dHe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706814111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXjF+P5a//40aojS9/M5jWJc+UF8Q6Ck1Ukhw35QwMs=;
	b=JP6v2dHeQO1Tc2A+JI8AfuHbWY6sT3uXKrdMejimSIzMG2NzDedHX8lQ/yenluPzMNZJi9
	yDKRTT1CBC0vNoT6B5zM6g3jWUeXeSBMZ/MDv2NksO/PQknWeMjYmAkrBJ0VjG2lnMMRYL
	lJrnIg3kCHqGvTsn3m7i+7hoITu08gc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-3ahjr3sfOoCmCGmRIQyRoA-1; Thu, 01 Feb 2024 14:01:49 -0500
X-MC-Unique: 3ahjr3sfOoCmCGmRIQyRoA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55fcdc80ddbso365840a12.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 11:01:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814107; x=1707418907;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXjF+P5a//40aojS9/M5jWJc+UF8Q6Ck1Ukhw35QwMs=;
        b=uTyfM+N+JS7oGINWq0dkcQhTqjJlq7CZOQp30W6lWSa8KDL4JIyQY9yFezpbeJVsRH
         ZTYVhliYVwXfRuatYOB0dc/TM2yAuvlN2NcGfQFbsQUJ4aH9OtJDN0yFRTsEundpXl1E
         6uwCTYojzwg5SwUZ5yG42izxTwy9O+zrZF0NLeygm/gnQGTFJM51x440/HfbOJIdMTdd
         pCdHym3fB7zMV9xAWKFeUgX2Vj0wXEpzTdU2NP1S1WHIDPyK6A8LSQvs1HjtCJG3C4YL
         773QBBkI/H5biLxix5qaWCPhaWQ3nJDdfz2Gmvq3J8UIrMTszTeytJmfNXA77OfIYWrk
         Mg3w==
X-Gm-Message-State: AOJu0YxgjRLIZe+tBZIVEeKKHH0inixld6ae8AFRZOGr4bDMvBrF58CQ
	Ij/Hvn2sjIuGpKa7NJsBvc/6JZcb9sLTpMZEZOci/6Nt85UKHyQfVQybD2kU8K4v2tdO/lvMe2s
	dJdshdk3c1lWH6YQQ2c7iCWAwKT2uQ2WNwSbi2oH9DoVlJ8+hw/2T/jfn/26IBJmsG64sF8YP5K
	d6xG1GnmChyzsIZlttp5Sc0M9D1XaNfb+HC/FI
X-Received: by 2002:a05:6402:f93:b0:55e:ed35:ffce with SMTP id eh19-20020a0564020f9300b0055eed35ffcemr3564778edb.37.1706814107465;
        Thu, 01 Feb 2024 11:01:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYzSFvK89MFlYCpuwbqUmRN+TweZauFcH382Mkey7YxA8GDuIW5OnFdjWmZAquYsgvP3jsZDqq2BtCzvDcypA=
X-Received: by 2002:a05:6402:f93:b0:55e:ed35:ffce with SMTP id
 eh19-20020a0564020f9300b0055eed35ffcemr3564758edb.37.1706814107171; Thu, 01
 Feb 2024 11:01:47 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Feb 2024 11:01:46 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-3-jhs@mojatatu.com>
 <CALnP8ZaPsOLK-Xc8vkXMO13NT4t52u6PH9v0PcKWX8Yy8gLCXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALnP8ZaPsOLK-Xc8vkXMO13NT4t52u6PH9v0PcKWX8Yy8gLCXw@mail.gmail.com>
Date: Thu, 1 Feb 2024 11:01:46 -0800
Message-ID: <CALnP8ZZ+=L0gWRc-kJUH51gfPW-aO0M16SDRk7O_qD=D3LreVw@mail.gmail.com>
Subject: Re: Re: [PATCH v10 net-next 02/15] net/sched: act_api: increase
 action kind string length
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 01, 2024 at 05:16:44AM -0800, Marcelo Ricardo Leitner wrote:
> On Mon, Jan 22, 2024 at 02:47:48PM -0500, Jamal Hadi Salim wrote:
> > @@ -1439,7 +1439,7 @@ tc_action_load_ops(struct net *net, struct nlattr *nla,
> >  			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
> >  			return ERR_PTR(err);
> >  		}
> > -		if (nla_strscpy(act_name, kind, IFNAMSIZ) < 0) {
> > +		if (nla_strscpy(act_name, kind, ACTNAMSIZ) < 0) {
> >  			NL_SET_ERR_MSG(extack, "TC action name too long");
> >  			return ERR_PTR(err);
> >  		}
>
> Subsquent lines here are:
>         } else {
>                 if (strscpy(act_name, "police", IFNAMSIZ) < 0) {
> 		                                ^^^^^^^^
>                         NL_SET_ERR_MSG(extack, "TC action name too long");
>
> I know it won't make a difference in the end but it would be nice to
> keep it consistent.
>

Despite this, please add my tag in the next iteration:

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


