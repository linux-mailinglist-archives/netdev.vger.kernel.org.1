Return-Path: <netdev+bounces-163802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC89A2B998
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD6A7A2204
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59A816C687;
	Fri,  7 Feb 2025 03:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NLhQ4+Rk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC816156F3A
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 03:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738898292; cv=none; b=nZ9kFEiIoBDRIC9xuCoriJSQNvFbyjdmQFRqFtV56d6BJRyoePHCiX+v7XysqYW3g+zg+g5T6M480JfXcv4WhNruQaDfoAgjKw06rLpc4KZ+JQWX1UJQQ1iXUV4ox+er1lJpqSqRhPWFpT/fIKdfjfcZ8UgwKv67/1cuTdsAQv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738898292; c=relaxed/simple;
	bh=vqL7xw8jlNr58XR+Bz0Kdoo+ACYUYOxJBFCw2VuheYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mr1EVex42vL9iRTQmBNb+LTJTMy9GHQdejjE6FHijDXq7pG01cmN7nCbs/j12aa/1CHyWLenwPwxg66rBhp7Wr0BhD2KYMEAMPeMM8K962asxhuiIW6b1WnfjP8lhyMXXZr2rJHWWjIdC0fF2yGLL0mTc845kEECSfNQM/fsPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NLhQ4+Rk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38daf14018eso1211673f8f.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 19:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738898289; x=1739503089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lm/AB3lty+Hlch8L0p4a3FVB4h5zLJbB7JP8TUeaKU=;
        b=NLhQ4+RkjCkH2lbGFXbz6nQiafbFK4GaH1+tFJM1JNR5MJqdc8YNFugDkROAUi+G2T
         YsZwD4fuORjt9Moue1Zngb373d1LBMjKlo8LEYEE7ZsZ8EY2oYQ6gcok1AYZEgQNzZq5
         1N7ObEhZkh9D9vUOGSx3LPZxf9Q+DI5MZ4duU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738898289; x=1739503089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lm/AB3lty+Hlch8L0p4a3FVB4h5zLJbB7JP8TUeaKU=;
        b=EHXX0t31L6im3FnsLSnVTJruipaNK5CRR0zIAXT6MCSOHTrwAn5yDWS7qxcO+MT7+s
         8SxClDBR+Vq8QYypiKRAbe9qP+k2w54RXGvb2EW7D6umWT1zAcByhC4GUmcD61CzsgFs
         E9h7TwocNh8ARjc1alXhnGMV4cJlIHVXRTRMzG974ngCZH62sKxx3Ql5DGezCpHDfe47
         O86Ij7HnIo2AP2BcaA5LzOHYcf+tHJvatNvPpJKfRNNIMri4jhdxtl0QrCn1ww3Ejq9w
         WC9DoSR1yJJZgt+WK2ITeZstUuXDIq2kRHXrJndV/6Kc22pEttTrt+OxQmHWRZhMEQyV
         o6zg==
X-Forwarded-Encrypted: i=1; AJvYcCUCexIjfdjyG/Au57ac+nabzHOKiTMW93JLS8TD+Caj3StTjC2VaTC6IFVjKkLqpIGCp3YFqI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5Q+KdxIw24/AzdEoXGXf9349x7mBZTcP135dya/Or05KXjcg
	zpqzK71ZxU8xSczrX5BAi8bAqcupyv3/riruVvcLqcPgJgpzLvxFV2K6PtNyslsbniUiiejfmF6
	U07FqlLkC3ZTmC32EklTm5V/tReHLaIt4nnSR
X-Gm-Gg: ASbGncvTsHpQdbGO0gyt7fdnOwBgOjwtLcPoptcsjMaaoAoFW4FA0ZkEXmj9QMLVW/+
	cQiVvV7XrGMsFjgxnSd23QldX7+N3Rqz37nMj9/hC7zXMQEobDvcae02JdPflkXLI3hvh45nA
X-Google-Smtp-Source: AGHT+IGgbufJoZgaw1aufBoiKaHbppw2L/63RQ7Kbg9CLe7VMVFZtWxoIcfYaDn8o0UPK8J6+CyQ5pO1U8PPRBCJQyI=
X-Received: by 2002:a05:6000:4010:b0:385:faf5:eba6 with SMTP id
 ffacd0b85a97d-38dc8d9b92dmr694333f8f.1.1738898289266; Thu, 06 Feb 2025
 19:18:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com> <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org>
In-Reply-To: <20250206164449.52b2dfef@kernel.org>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Thu, 6 Feb 2025 22:17:58 -0500
X-Gm-Features: AWEUYZnWk6trO8wL0uhorILjdXFks8iTPAcYKElY2-JZ81kkM7gTCevOLbdyxOk
Message-ID: <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
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

On Thu, Feb 6, 2025 at 7:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  6 Feb 2025 20:13:32 -0400 Jason Gunthorpe wrote:
> > From: Andy Gospodarek <gospo@broadcom.com>
> >
> > Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>
> This is only needed for RDMA, why can't you make this part of bnxt_re ?

This is not just needed for RDMA, so having the aux device for fwctl
as part of the base driver is preferred.

