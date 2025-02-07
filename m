Return-Path: <netdev+bounces-164236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C24A2D17B
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 00:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BC3188CDE3
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 23:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF8B1D8E12;
	Fri,  7 Feb 2025 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LURJPCuy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4D1D619F
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970969; cv=none; b=W2+k6Jro8g4Zoc1voOktu5uSFg/9s6mRPIVR5Bjqsz0sTxE/Oy44iF1D3326D2281Fb7r50Ui0L0v6ecbGBjn/o3I8dO0lppovO3hqx9zI/rJKWnh1T33LG7IuTxLLwJHqjcL1M+Ng3t/OnvgyGZ6F1AxEG9mxz4xR2Kv+p76cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970969; c=relaxed/simple;
	bh=LfbUpyjGHYX7RFAeqCfeoZO0Lm3old+X04Jmz2KNwmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4vFo9r/Zi8k5nLx6qJgxwun0DyzfMeaK4YAz4OYVf2O2z4IHA0KNi8Elg8yTVA+Yu0zv1UMdW4eue4CEXEa0cLBwSKCfAvedcWBpI9yvn/7Dvajo9tDgi2w6APeZuNRkHxKW14r5WIzqIhFFijf33saXCVydIDv3i87i7qncvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LURJPCuy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso15611915e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 15:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738970966; x=1739575766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxrq3y0zWcusMdm5gKmy0RSUVEtUhaV6df4ledtnR3g=;
        b=LURJPCuyQgUJiHM0ekNEUJhwT9HGdVn/BUc86TurajLss3++4qObzPhdi9LtvDTAP3
         /wOsmYOYVGbfzkm16YzzBm189BGGCJDAq3O08LesEsoNjPAClHMSdwSdWiSVAl7j1oxD
         CNehSCZ80Xgpcm6wYuGExmnKY7ycOGYDWYf+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738970966; x=1739575766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxrq3y0zWcusMdm5gKmy0RSUVEtUhaV6df4ledtnR3g=;
        b=uWxt81/wxxNWs6aUYzqwKohPpm6abaKrBze9x1FYVwHHzGir8194yzj4Hqi1M40h21
         rzcGebWf1BV/Wm93A85pGe0ar1ftp6zRxX/MvgMCCevTLEuzO9m2hyvSeSzPMPdZVzgP
         UV7+FfRFDsdbDi5thX2EU34rv8FacWnXSJofXpL+pD60kipXOWVimoqJkcbshOU4nIRs
         W2gclHBWxKNUp/QQs8HJ5OjE/RQ8LCbKDh35hDLZycucg7JQbQsHegZqjLjZIDoXMaNv
         LufPBjUbMZ86ngS0D8kASgdnsuOkyNUT4ylgJUgp+UUZgnzzmys/q5ITV/vtkfOu+VIr
         ECuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwcX1mkaMF5yqUWweqoQnqjAbtZE7CAxfVG25Y44EL/KtWbEAsQuGt8SZV2k/ADVOm7Fz50HY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Jkscl/iC4AmKEveBrKCYPu/3V5bA29IshToQB18xxcpA+13p
	wj1g+7ieK0QUUBay6f0vl8BHuhFXIIwfkffjjFQeQLW451V40rBFI0TeJVY+2scfURGBvqGf8ji
	H0LyBx3T7HSl78SaioJNbZHsXPXIMJ/sr8h5M
X-Gm-Gg: ASbGncs7laL1H65uvBx8cNX+Cyn6L7e+ur0MXqtIV8SPX1K5GWbYYC1/xbDJV4Tq/Ou
	ZG18f7w5nWGEaIW6XdZPIlHHRtjZ8MmiTdjFUbyjvrqqV/ibzBQg/dgiW26lLdrX0JNXOyFy3
X-Google-Smtp-Source: AGHT+IHzbgTJPlwhp2rxVyfXTFAiBs82aNuiqx6uZAtVL2iql18//vPZ4iyLFNt7DsusmD2ZyYpKKa2AXyZ4gTFATlw=
X-Received: by 2002:a05:600c:a47:b0:436:e3ea:64dd with SMTP id
 5b1f17b1804b1-43912d3ef4bmr72734975e9.11.1738970966099; Fri, 07 Feb 2025
 15:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com> <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org> <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org>
In-Reply-To: <20250207073648.1f0bad47@kernel.org>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Fri, 7 Feb 2025 18:29:15 -0500
X-Gm-Features: AWEUYZlrtI146fT0ZIPrxYebKfGyT2dPVkxZPcjyu29IMriUNecpOQzGJhSSMY8
Message-ID: <CACDg6nWU7XXn4X3LGy=jxREYDDVaqy1Pq19kt93wQPn_US9iiQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Aron Silverton <aron.silverton@oracle.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>, 
	Andy Gospodarek <gospo@broadcom.com>, Christoph Hellwig <hch@infradead.org>, 
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	"Nelson, Shannon" <shannon.nelson@amd.com>, Michael Chan <michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 10:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 6 Feb 2025 22:17:58 -0500 Andy Gospodarek wrote:
> > On Thu, Feb 6, 2025 at 7:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > > On Thu,  6 Feb 2025 20:13:32 -0400 Jason Gunthorpe wrote:
> > > > From: Andy Gospodarek <gospo@broadcom.com>
> > > >
> > > > Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> > > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > >
> > > This is only needed for RDMA, why can't you make this part of bnxt_re=
 ?
> >
> > This is not just needed for RDMA, so having the aux device for fwctl
> > as part of the base driver is preferred.
>
> Please elaborate. As you well know I have experience using Broadcom
> devices in large TCP/IP networks, without the need for proprietary
> tooling.

I totally get that.  As a user it is not satisfying to have to
download and attempt to compile complicated proprietary tools to use
hardware features that seem like they should just work.  I don't think
fwctl should be used as a crutch to avoid doing the work that is
needed to get support upstream.

> Now, I understand that it may be expedient for Broadcom and nVidia
> to skip the upstream process and ship "features" to customers using
> DOCA and whatever you call your tooling. But let's be honest that
> this is the motivation here. Unified support for proprietary tooling
> across subsystems and product lines for a given vendor. This way
> migrating from in-tree networking to proprietary IPU/DPU networking
> is easier, while migrating to another vendor would require full tooling
> replacement.
>
> I have nothing against RDMA and CXL subsystems adding whatever APIs
> they want. But I don't understand why you think it's okay to force
> this on normal networking, which does not need it.
>
> nVidia is already refusing to add basic minoring features to their
> upstream driver, and keeps asking its customers to migrate to libdoca.
> So the concern that merging this will negatively impact standard
> tooling is no longer theoretical.
>
> Anyway, rant over. Give us some technical details.

The primary use-case that I find valuable is the ability to perform
debug of different parts of a hardware pipeline when devices are
already in the field.  This could be the standard ethernet pipeline,
RoCE, crypto, etc.

We do have the ability to gather all the information we need via tools
like ethtool and devlink, but there are cases where running a tool in
real-time can help us know what is happening in a system on a per
packet basis.  We actually did something like this this week.

When I look at fwctl, I don't see it as something that is valuable
only today -- I see it as something that is valuable 2 years from now.
When someone is still running v6.17 and we have discovered that a
debug counter/infra that was added in v7.0, but they cannot use it
without installing a new kernel or an OOB driver we don't have an
option to easily help narrow down the problem.

If a fairly simple tool can help perform RPC to FW to glean some of
this hardware information we save days of back and forth debugging
with special drivers to try and help narrow down the issue.

