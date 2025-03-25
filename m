Return-Path: <netdev+bounces-177543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE76CA70849
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C92F1666B1
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED9119E971;
	Tue, 25 Mar 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=insidepacket-com.20230601.gappssmtp.com header.i=@insidepacket-com.20230601.gappssmtp.com header.b="d/gGRGNy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C63234964
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924019; cv=none; b=arceZdnIvhSkB8yXXhDgQvk8fMujxJdfpfJRlN2XMTvdCN1x0FmcIcWYt7a6n2uoltJPxhoDKVj+nbLT0QfD8yvkTKeNjlrjrB+Yl1rA/Dh3ybl78qSSphvQcnOk5Tf2htdGb/8SL5/hMgjZKWy5+rStULkc9QHvUZo2y8qHJqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924019; c=relaxed/simple;
	bh=XvKo2kCSE1hUa4iyrsUCh76FeiEKIDTY4SmAmmXMA/E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c7qR8YF/Bvwxp2mvq4hqB3iMfUmGGpQyNg8QFC4621tWO6NvmTHTLotbFHSIeBEM5GEK+8nB0uiClP+MjZqWcjQkXo6QQSobUSKPLY9fDC+/ZLX85tzU9hK12kUVFq0bM/brpMGcLXCi+IRGVehbeAYi/vBa9XZGjnZ/0uysRx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=insidepacket.com; spf=pass smtp.mailfrom=insidepacket.com; dkim=pass (2048-bit key) header.d=insidepacket-com.20230601.gappssmtp.com header.i=@insidepacket-com.20230601.gappssmtp.com header.b=d/gGRGNy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=insidepacket.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=insidepacket.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913b539aabso3274783f8f.2
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=insidepacket-com.20230601.gappssmtp.com; s=20230601; t=1742924015; x=1743528815; darn=vger.kernel.org;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvKo2kCSE1hUa4iyrsUCh76FeiEKIDTY4SmAmmXMA/E=;
        b=d/gGRGNyAGtOpyDPUYwpPwdBcWVHJStFbnlVfRC1hdvIy+0wV0542HhSsujIXDj7OU
         sl8fxp22/hx+6XG38VDRaiBgC3h9EujfZyhGMaxeKk4sLsuPUsBrPC1jrkPYvvvW6BlY
         RexUuBEymAzqPJfoDtpOCwWmUUXIt0aaiwOyxcl4mKQeUyXYfEjVv9qGVzzSKEwOI8n3
         ZGfqXgwoHaqKRDsuOEyIix2qUpWcTVVuwl6X/AAbKotceakJdtE9YoswchwB/C1kD8ww
         R71pBu/At9Qb3ZvZGWMyizpXX8xzNOgbqoVNZ7nmHLuPIq/Bt6cNDQQnc+YPRIbD982X
         M4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742924015; x=1743528815;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XvKo2kCSE1hUa4iyrsUCh76FeiEKIDTY4SmAmmXMA/E=;
        b=MasZMs8Zx1BFiaTYTMxUcVMjwrGXVTnZOE2npb+2TyrR8kUN7Jf79DjWe2wsKQ2oZs
         t6wjxt6ILmhngQqIMv6Xc6Co5I/LVMRqEd8NfsNEgbd/67DKgBu9nzOT+y8L043bSjEq
         fpEyC2H4Ky+JRQwnR4t1tjUlq4LF0btsZm7XEhs3AdT7E1ojEiVb2XpbgDYcDIKRJein
         2yQnYcY2riAdCUFWyOlU8M4kwcOG7PH+t3FRO6Y6GR4nWwUiljjYWO+ejMF71D9rd0VE
         n9nfwMBQVQxcY77Pt1SOIe6fFOdiAm+/D7dxHy790FCajKf+mQLgUSXq48vpJf3UHIqf
         EyFA==
X-Gm-Message-State: AOJu0YyIXf5QjZhXprHwddeDgnlZGNsAWSLpbNrCJ5DK8Wequ+LXXA0F
	3koBeo2LRUtosvfAFd8E285jPB9R3nnqv8eKoGelxCyMHaxIvjr1+jweJe75zfB+V9B1ptaFIDF
	r
X-Gm-Gg: ASbGncvKZIvY45WrwZ5AUVB9YKkon1IpmGfEWJ6UJ/tG1Ff8QlFzIAFCKuqnAnUHF3e
	foMLDoJOj7hbdhLNdp28KcnHWoysz05HfG1eZu97SIgLagC0iy0BJe8l7J5Pbn5RmbFUXx2bDOH
	tHOlBP+DSb4HZR/Wt++O9B7jRMjRjmHBePRkVnhEyjiFmk+aXPwTvQ3Jveg5rVjxMJ8Qc/W7jlZ
	PjlBs0ClDsEcQn+vc95qxgHquODC9NiiJKFHrb91ZCByBzhPSYR9m84EPJJw6//aMbsmM/asB86
	QpAyvOtN21rm018zD46YkcLP2/nb9pvqQoCfCVvSnKnu/epgOSZBirMeM3hF7uzt4JaWp2vdHQt
	8
X-Google-Smtp-Source: AGHT+IGinoxR+GZ/HVJcTEOVEM0wDptjvcp98u3jdh2sYiWM6k+3te7eQBWd9rhMt2EzPROq03KuyQ==
X-Received: by 2002:a5d:6da5:0:b0:391:2f71:bbb3 with SMTP id ffacd0b85a97d-3997f958f34mr14530412f8f.46.1742924015036;
        Tue, 25 Mar 2025 10:33:35 -0700 (PDT)
Received: from smtpclient.apple ([2a0d:6fc7:722:17b9:f1aa:61b4:bf67:cab0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f99540bsm14188198f8f.2.2025.03.25.10.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 10:33:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: ethtool read EEPROM
From: Eliyah Havemann <eliyah@insidepacket.com>
In-Reply-To: <b5dflgmqztzjmt42rw3x5ccrdth7qkc2kicr6jtofkkrmyo2cy@utly225o6zn3>
Date: Tue, 25 Mar 2025 19:33:23 +0200
Cc: netdev@vger.kernel.org
Message-Id: <B26690A4-C7E8-4D68-932F-D017A645989F@insidepacket.com>
References: <b5dflgmqztzjmt42rw3x5ccrdth7qkc2kicr6jtofkkrmyo2cy@utly225o6zn3>
To: Michal Kubecek <mkubecek@suse.cz>
X-Mailer: iPhone Mail (22D82)

Hi Michal,

thanks so much for your response. I will look into devlink and am looking fo=
rward to your insights!

Best
Eliyah=20

> On 25 Mar 2025, at 19:03, Michal Kubecek <mkubecek@suse.cz> wrote:
>=20
> =EF=BB=BFOn Tue, Mar 25, 2025 at 05:16:52PM +0200, Eliyah Havemann wrote:
>> Hi Michael,
>>=20
>> You seem to be the current maintainer and top contributor to the
>> ethtool project. First of all: Thank you for your contribution to OSS!
>>=20
>> I ran into an issue with a whitebox switch with 100G and 400G QSFP
>> slots, that I was hoping ethtool could solve and I want to ask you for
>> assistance. It=E2=80=99s pretty simple: I need to read EEPROM binary data=
 from
>> these QSFP transceivers, but they are not associated with any linux
>> interface. This is because vpp is controlling them directly. The
>> ethtool has a function to output the EEPROM of an interface, but I
>> can=E2=80=99t feed it the file back to it to read it. The file it outputs=
 has
>> the exact same format of the file the whitebox switch provides. I
>> created a small python script to read the file and it gives reasonable
>> output, but I don=E2=80=99t have a way to test this against a big collect=
ion
>> of SFPs and I know that this work was already done in ethtool.
>>=20
>> My questions:
>> 1. Do you know of a tool that can read these files that ethtool
>> outputs? Maybe it exists, and I just didn=E2=80=99t find it=E2=80=A6
>> 2. If not, can you provide some guidance on how to add the
>> functionality to ethtool to read EEPROMs directly?
>=20
> If I understand you correctly, your problem is that ethtool can
> interpret the content of the module EEPROM but cannot read it for
> a module in a smart switch.
>=20
> In general, devlink should be the tool designed to handle smart switches
> and similar devices and their components. I'm not aware if it can also
> interpret the module EEPROM content like ethtool does but it's the tool
> you should definitely take a look at.
>=20
> Implementing a feature that would allow to use the ethtool code for
> interpreting the module EEPROM content also on a dump read from a file
> is something that would probably make sense whether you can use devlink
> for your purpose. I'll check what would be the most appropriate way to
> do that.
>=20
> Michal

