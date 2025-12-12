Return-Path: <netdev+bounces-244459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EECBCB8066
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 07:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D86EA3020361
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 06:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7F930ACEB;
	Fri, 12 Dec 2025 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="g+f4vorg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3422561A2
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765520050; cv=none; b=YD08Kdzc+YJY1ZnB82I9VImWu7vicxOC7JKE9M9/GDPLrOHHN2S6hcI0Do5wuHCUPvJw1Sau2X2BXRcukwJKa4GE0ysCYKwqYWQeFnxrVgZMVZDO03hCOnkts95QiUToG6cYM8AY5zpVwWy2HewQrTAx3HPOVx0D7xhFZA/gvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765520050; c=relaxed/simple;
	bh=kts9qOHGFx+4wsGRL+VbClZt4U0aWqbyCfH2QemPSxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPp4I9p2WGmAlVJMLI1JbGYTDkas5zBWaBXzRlHisK/QexXUjAQ/CEdaN3dgpufliXr28RCnnqjyQmqDoq3T8q/lU/Pl1fk/CkFVnEppNnU9c02zisCAcs8qOIOlPKvVDTzObY9K/Vo/cRkUZEBg6yoRul0UZxyeW6wK5aow30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=g+f4vorg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so798169b3a.0
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 22:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765520048; x=1766124848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/ZINYaYptiRfjxb2oDbN+WFnXddqHeRBuKm2lywsdo=;
        b=g+f4vorgfBDhUkkBCZs12C9mNrVqZ+je3lDzfleIbClZr+TsL4md3LbYGOmtCCkbmf
         DUwzyIEhik/u5WUbys0BG+E0ydSTsQK1leAXNVWQLHoOzdbLb5+NGDlVbnxor0soAP+M
         0mHkcpabbNlzIIxFGwwbW24Te8UCn90rrRQuaPjZ+ad3eQCpjXY4OC6N/5HaSoPbHg0d
         EoDVBRo2vbL27mdFD6weOk0b5fedyjH4C0ASi56ABA2vuN/kT5Uum3mgR7EqonFba9Ne
         WWr+gIg/2+um49AZ2SP1pjF9RXlP6cbCvpYEK5aarxNJVkp6XglbGGZrHwVGEgRtBguP
         FoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765520048; x=1766124848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8/ZINYaYptiRfjxb2oDbN+WFnXddqHeRBuKm2lywsdo=;
        b=afr++ZFAXL/sssO5h7UXIKUQzYc+ODfaKd5AKZoFgphy/4x1fmV5KnF9p+k3ACMPZc
         kNr7444Rauhqowepx4cQURCcZXi1Ym0rU/K1IJYOlR2glhPBAXNj02xRHlY5RpoIVzHo
         7CKuZRG8xqA34qvFn3ypE6gy7LzUHJ+NvwHAkQXbLX9wUbfubJjGuLhebX2EDyqdmEjw
         kfCcFFLN3bfm4g4L6kCbaKvweTDXYIie2FHgSyqcLGazgDFfi3WWaEGW/YzqU+XOPFba
         GDkPVTzT+DOOCqW8ujd8c0k6FJo3OcIgPXkwXNxI5m0/DLrlHZ8SteZzueDY7LpGrFYJ
         bGmg==
X-Gm-Message-State: AOJu0YyrQ0Vm+T5IxQPVq9uHI2VNd5IhGj73K01zm0z0/g1T7KdAlXRe
	fo+XyjHPl3dbWc/i76zzGSmaKVK4GAi/2GHotlqsqsNKSxoHt5toSeCuPkyRD4Kz1Jw=
X-Gm-Gg: AY/fxX7Mod1WXm4grY+/ivaqrLTZ+rR2v3nOkHYRzrefBYH4ojD2CzCzKrmTlGNKkXC
	kj5aWNjnxiNsLdVOjLqE9FUPVxpIh5aSYMqNMmJjh2jWyE4pTZbI+AhcrPjdqfG1d6vIGsG9IF4
	W3Rm5Lq19lamsrtm7XsiMdxs5CCgvJH5nDgN+o1/2ISWHdTBpUiTXOK5TH6Y+BoP09YdGXHCJ/l
	eu4pKQq8gmfSAkYkpJ2URHloziiE280ReUErhEx7PBHLYCMxCox5RIRPqgfBEjMWD0c/h96G2Xl
	PwZ++Ur5pCWtJx9zloJwH2PenVklAaQvN9oIS3toTwxYuNRNlNH4igvKbXQoiRb1mfw/sc/ru/I
	uZB3Vxgq7GllhEdthwtHIgNu41JzBfDkf7q3yAG7DzYKqAOSsWewowdc9v+rrdE836J4W3mRZ7S
	HRFQHcJZnqScZjz6Vk+GDFcltHET4ihPI/8/fBXCgG8IYmiQt/01Png0MOm/zMB/tB/3M6PMI=
X-Google-Smtp-Source: AGHT+IEtugynmbnhWGoysPxWzdvBHGp0nAnADujyUSvMA+w6Z0F6v4qTwdBExpY3RhLy1P5yha9f3Q==
X-Received: by 2002:a05:6a00:ab87:b0:7e8:4398:b371 with SMTP id d2e1a72fcca58-7f669c8b175mr1031305b3a.68.1765520047958;
        Thu, 11 Dec 2025 22:14:07 -0800 (PST)
Received: from stephen-xps.local (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c5093d7esm4106641b3a.51.2025.12.11.22.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 22:14:07 -0800 (PST)
Date: Fri, 12 Dec 2025 15:14:01 +0900
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Eric Sun (ericsun2)" <ericsun2@cisco.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: bridge-utils: request to fix git tags
Message-ID: <20251212151401.3b3228c4@stephen-xps.local>
In-Reply-To: <161B0C34-1F18-4010-B89B-738DA12F77DC@cisco.com>
References: <161B0C34-1F18-4010-B89B-738DA12F77DC@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Dec 2025 02:26:02 +0000
"Eric Sun (ericsun2)" <ericsun2@cisco.com> wrote:

> Hello,
>=20
> The bridge-utils git repo [1] has several tags that cause recent-ish git =
fsck
> to fail with the missingSpaceBeforeDate error [2]. This is frustrating wh=
en
> working with github, where such cosmetic errors are not ignored by defaul=
t as
> they are by other platforms (e.g. gitlab).
>=20
> Though bridge-utils is deprecated,  I was hoping somebody with access mig=
ht be
> willing to fix up the tags?
>=20
> I've verified that something like [3, see: "How to work around that issue=
..."]
> address it correctly.
>=20
> Thanks in advance!
>=20
> [1] https://git.kernel.org/pub/scm/network/bridge/bridge-utils.git
> [2] https://git-scm.com/docs/git-fsck#Documentation/git-fsck.txt-missingS=
paceBeforeDate
> [3] https://sunweavers.net/blog/node/36
>=20
>=20
> Cisco Confidential

The AI answer below is correct for this.




These errors indicate malformed tag objects where the tagger line is
missing a space between the email's closing `>` and the Unix timestamp.
This is a common issue with old tags in repositories like the Linux
kernel.

**If these are upstream/historical tags** (most likely scenario for kernel =
work):

These are cosmetic errors in the object format=E2=80=94git still functions =
correctly. You have a few options:

1. **Ignore them** =E2=80=94 The tags still work, this is just `fsck` being=
 pedantic about format compliance.

2. **Suppress the warnings** by configuring git to skip this specific check:
   ```bash
   git config fsck.missingSpaceBeforeDate ignore
   git config transfer.fsckObjects false  # if you want to suppress during =
fetch/push too
   ```

3. **Check what the tags are**:
   ```bash
   git cat-file tag e601dc1094107999de050b7104bf01ce865fe60f
   ```
   This will show you the raw tag content so you can see the malformed line.

**If you actually need to fix them** (e.g., your own repo):

You'd need to recreate each tag:
```bash
# Get the tag name pointing to this object
git describe --tags --exact-match e601dc1094107999de050b7104bf01ce865fe60f

# Delete and recreate
git tag -d <tagname>
git tag -a <tagname> <commit-it-pointed-to> -m "message"
```

But for upstream kernel tags, the standard approach is option 1 or 2=E2=80=
=94the malformed tags are historical artifacts that everyone has, and "fixi=
ng" them would change their SHA and break reproducibility.

