Return-Path: <netdev+bounces-139523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C759B2EEF
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A3928319A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B408E1D31B2;
	Mon, 28 Oct 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="NjXd1y07"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29418FC89
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115152; cv=none; b=DkGCH3VHMrZjKdvk88h2JdmNdhdfoGORNqUNkPJHlWIdR6SSDAKJfVTzu8pOO6ce/tXZlX277m2Qj6zcv0HbqyKJWq1y0wqtm+k+MvmSSGCs1tf75cfs6ZSA4Gvg+lks7dzb7ANwVycN2Vxt7jrSHqvkq3+8lqPSGZB/gIfBr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115152; c=relaxed/simple;
	bh=L2bXbq3PIxh7Zm3SHa0cpC0fOa4pqViT0QVnHxOBQcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHkVNXm4Da734u7fACBelWfAfuuHuMRnh6BKAtIXsdfTJRaFS/VgBQOfgLTRneZQffSrZB74R4+oSoOYybw/8KZV4ikYv4CZwG3pV+Y6MwB+0nLHBHeplv11YKDHJ+Ertr1aO532TmttSzIxAyE9J5OwYnew2tJuHxwCOCamxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=NjXd1y07; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7181c0730ddso1655871a34.2
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 04:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1730115150; x=1730719950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/DR918lxz2xV2iocC5zSbeuPsDzY0FXd6yi6ZYmadw=;
        b=NjXd1y07Cq4ceq1+fYrsKgbDb3MQStdhHRp5NOrf5w+BEqzjZXYOjqfr+xkZwTf3vC
         6raSWOuLvY2e07JLK/KNYCIrURO+hg4cH3PgRL03N5c1QBEZPvMnJoFYd+dJTXSIQzJd
         NEtKw30TKH1k+tWA1f2m3xt182s0TB2mwiJFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115150; x=1730719950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/DR918lxz2xV2iocC5zSbeuPsDzY0FXd6yi6ZYmadw=;
        b=rkPRgUSKr1+Z6V3Z7i5T5xPIPs1AkiHEFM2JdwWXkb7tFnBZA8TQaWgygWuODho/iN
         pyCz2Y895+yhDR1NH/tBQ0eQrgx7ROK/UF/AFCsZ6MldG+RuSby2nrdIZD+Cpx6cY+NQ
         /UY5HNYSUrANr++yYd0Ap3H+IL5TWNdbuajK9R+ukUbS9OMT/sNeyZHPXATYb1IeVufn
         ncnuHH2Oq1OPLoajWz3me9ZsfkIxWFhlevE+avFv/0oYd37VMBeMzn1lA1G1SAg6pN8e
         BrS+Rt0vEpGA9LJhkK2+8PdIoiVsMjbk6E09lUcGq1xv35zRDYRkx0E37gSEjfMlB4uw
         A5IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuxA5VTX1xOtvRFp/ILYiyQTpp67LSc5Nu4exGS12eI+BEJwYkXTosFGTGL9SqwuSWeHkXi4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx8LdkOxF1MEeQCmpjDi8n9qvXA7Qp+Rm1CThg0DH4Rz0RMW74
	EBFShYSFpVU6VNKylROgTJaUr1FSq/L6ugV72F6mFYEoeibXOTgdQ/vHqb9Nqps05c+gcGtof2M
	ihiWp2W1vne1wi9kL6z9RSlB1WFEj3E6jaxJTMw==
X-Google-Smtp-Source: AGHT+IFjImVBhmJ8dxS5xkN0jdCuK5nMHGWj0G72Dd2XGbFptWIit1vsNfbMq6ubR0LUFbnUWGrNiUL1xyvI3FLAcTM=
X-Received: by 2002:a05:6870:e0cb:b0:288:5f71:4e71 with SMTP id
 586e51a60fabf-29051db63ffmr5822247fac.44.1730115149780; Mon, 28 Oct 2024
 04:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1729316200-15234-1-git-send-email-hgohil@mvista.com> <2024102147-paralyses-roast-0cec@gregkh>
In-Reply-To: <2024102147-paralyses-roast-0cec@gregkh>
From: Hardik Gohil <hgohil@mvista.com>
Date: Mon, 28 Oct 2024 17:02:19 +0530
Message-ID: <CAH+zgeFzURTdg5n9kxXb-yMcAqC1rp6Y8t426YeG19YwWayXfg@mail.gmail.com>
Subject: Re: [PATCH v5.10.277] wifi: mac80211: Avoid address calculations via
 out of bounds array indexing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, 
	Kenton Groombridge <concord@gentoo.org>, Kees Cook <kees@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>, Xiangyu Chen <xiangyu.chen@windriver.com>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Oct 19, 2024 at 11:06:40AM +0530, Hardik Gohil wrote:
> > From: Kenton Groombridge <concord@gentoo.org>
> >
> > [ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]
>
> We can't take patches for 5.10 that are not already in 5.15.  Please fix
> up and resend for ALL relevent trees.
>
> thanks,
>
> greg k-h

I have just confirmed those are applicable to v5.15 and v5.10.

Request to add those patches.

