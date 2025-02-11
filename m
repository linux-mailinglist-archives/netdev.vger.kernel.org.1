Return-Path: <netdev+bounces-165250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD89A3142F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683D61887C53
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E051FBE8D;
	Tue, 11 Feb 2025 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="cvyg0iDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0D1E5018
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299099; cv=none; b=i5f+HMs6dqEGg7m3bw/MRUMmTCIkI9mPoAMj1rpnz19Rb2TJ/txMgoTZUhWXFs1+ceotCRCmoDbx+l3yiDTURk3RhrvGoGK78MKfKZTMVtKh+lgn1GYi+7wskd2oaCqVUkLQLzdU9VntNjsKN4d7WERykG7Z/QfugNbYezZ3YVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299099; c=relaxed/simple;
	bh=XvDuCodpaqcxTKThvBpmrszrt1+9RjwtdyN354TnO2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9saXWWaVZYoM8wERwfnahXx+ufcpGqa6+6xl7DU2EMboFR1DCmf+AmiTZzcu9oX1c1qBhWqBoIrVPSm/vHrcQzfKXPSO39Oguyu1T/Z2zImMwlDJ4pTG79MtKb6nMIb9LTG3JcM7Ui6mfS28ITt7RScx1FJXd68cUKByh/6fcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=cvyg0iDq; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dd1962a75bso42399876d6.3
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 10:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1739299095; x=1739903895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvDuCodpaqcxTKThvBpmrszrt1+9RjwtdyN354TnO2Q=;
        b=cvyg0iDqDgA4SPqOZvDlZJSpFrXCToNTo9g6nyw71b2FdaY4R5E8ryBiNmaD2aar1L
         8ZdWgpcjdk6ldlG85y9bEYyA3wZT4WbaSCip/9f2yfRSXyUDTGm7vGixoVl6SdE4CMtS
         PbOknc/RS+w/CQHauNs0LNadBJTAhwZjxe383/+xV5C8JF49giltM4X2KHGDqswxayWI
         zNis8REOrwl10zp42jzgH5eJYhnk/RQfT7O/CLuDgF2+3xuLZNXY0O97Nxmkvz+6jGw2
         slrncdtRhx58rHhbsvcTELurCNf0wM8+ju2AqwQJRnMlZBq97NCcKsOCXCkCUcRM3gNK
         yrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739299095; x=1739903895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvDuCodpaqcxTKThvBpmrszrt1+9RjwtdyN354TnO2Q=;
        b=PN8SxFOTr5w6OnPywgL/hjUzBHKHjNqk/Dcr8bwXL0XmxfPb+vi1iYSzqpg7+LfcVF
         GlOOcPKSHt8MLIWus5qNnZl2nFKido0t7nEwkkNUVRJpqf0JiRv5Lx9ssctKFThGgbht
         OwNJBSuuEu00CgozjFXTq7kXHMBzrYavVKNTYwwYbQSijbomughpWSwGlQCq/vFWQPwv
         8GbXA2ar6MPdDWxDOvW0PUppWBIEDqdOjMfmMUpHfYoPFYe+IbJ4XTUn9f69G8JLzwpW
         /RVjPODQWjnHp3V349WGl5B/Ri9+7Oajm+4GaYL50dHfW+jXxnSxUeAZ74IeZvQC8Tx5
         HRpg==
X-Gm-Message-State: AOJu0YzpukBNutIHTYuF/W/C0H3s9pXLDlQnTI+wtQ+mfrbdl+Rum+hI
	0QyJPUGgmS8ev+VmYQM7dKm15MUFo3X9ADWAI5vBRUc+2LAQlLr+66SfEq/LmuiMdDpF7aCZwEW
	5Phm+PoqQE0Z0bQ2g2VxN46DjrC2bpTevki5jmM+9ElcXICjnADgtdQ==
X-Gm-Gg: ASbGncuwivSbuCa/SxNdRx8aC1UHAnNMH7tLhQBCDXSiAEng958+gr6g/lE6jYrlOAj
	yCoBEPeX0/II5w4GuN7LkfLst25eixZ9PR79fExAoUBpzm/EHz9wKUFn8+yDffBSXRgh+u0Y=
X-Google-Smtp-Source: AGHT+IHLuFlvcsAWDKynxyZuz4MbSaVDrXe9sdQd4ayDP87CY/VufY/4KtnBuu4fVjJLh/2Ol1jK8DY5DaGt3VWI8ho=
X-Received: by 2002:ad4:5d6e:0:b0:6d8:8256:41d7 with SMTP id
 6a1803df08f44-6e46edada18mr6706236d6.33.1739299094739; Tue, 11 Feb 2025
 10:38:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206015711.2627417-1-hawkinsw@obs.cr> <c3aec7d5-8c28-49f8-ac0c-18436d5b4da5@redhat.com>
In-Reply-To: <c3aec7d5-8c28-49f8-ac0c-18436d5b4da5@redhat.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Tue, 11 Feb 2025 13:38:03 -0500
X-Gm-Features: AWEUYZkG8dAwZLmALDOhpD0OPT97beErs848zXdOSyBoPdOf5MypdS-eh90aKQA
Message-ID: <CADx9qWhEZmkhHE+7cxdwcE1WACGMczV1zJ=S7KQdtzMhX6Hm9w@mail.gmail.com>
Subject: Re: [PATCH net] icmp: MUST silently discard certain extended echo requests
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 4:12=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/6/25 2:57 AM, Will Hawkins wrote:
> > Per RFC 8335 Section 4,
> > """
> > When a node receives an ICMP Extended Echo Request message and any of
> > the following conditions apply, the node MUST silently discard the
> > incoming message:
> >
> > ...
> > - The Source Address of the incoming message is not a unicast address.
> > - The Destination Address of the incoming message is a multicast addres=
s.
> > """
>
> I think it would be helpful mentioning this is for ICMP PROBE extension.

Absolutely.

>
> > Packets meeting the former criteria do not pass martian detection, but
> > packets meeting the latter criteria must be explicitly dropped.
> >
> > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
>
> The patch should target the net-next tree, and you should add a related

I am terribly sorry for targeting the wrong tree. I interpreted

"As you can probably guess from the names, the net tree is for fixes
to existing code already in the mainline tree from Linus ..."

incorrectly. I will adjust in the next revision. Sorry again!

> self-test (i.e. extending icmp.sh). Also even if the new behavior will

I will absolutely add a test!

> respect the RFC, changing the established behavior could break existing
> setups, I *think* we would need at least a sysctl to revert to the old on=
e.

I agree and will add such a sysctl! Thank you for the review!
Will

>
> /P
>

