Return-Path: <netdev+bounces-143096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F29C1213
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 23:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DADABB22A16
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5E218D64;
	Thu,  7 Nov 2024 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThNHLyBo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BAA1DC04A
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020287; cv=none; b=Lz6TN6QTwioPp2OmyXGb5qlzIgJq3Y1pqZS4V1mrEx2GEUjjhNQ27rhRpYGiC9DzCkLcLwLa6sV6lE7fqRB6mslVtvmZ2cKbDZbIYMRrX0Rgry7y/KwauD4eYNBz7zAM8l4GVD4TUfQa9tqih4RySEfVJ+6kGFYo13xaD9p+96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020287; c=relaxed/simple;
	bh=n2mUQAjp4rvZTtEi4u2daxcIxqByD+sMw3XpgzGgrqQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YLxYuIIxET86vtJVuRfZFvxSf9UsrSUzdRIHLEvTwef3B2VBavx18xAKl1Zs+13WoHONS6LaCNmkLRknMkpJrx8tPPckVrZw+uG9y6KBK7LR3TRZTgBVHWaO6iFImjlHRwjic354O1LYGCCuFV737Qw9AGA+JN0xpi8jkNywbNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThNHLyBo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9e8522c10bso224194166b.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 14:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731020284; x=1731625084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2mUQAjp4rvZTtEi4u2daxcIxqByD+sMw3XpgzGgrqQ=;
        b=ThNHLyBoyADFKEeBuex63fYCnT+6j6JGSOzPItdUfLyOiRcMbGtPMs5KEpHK8bQWWv
         IWIVHgnTnVS54acQMVkbvBLgO0D0i2g1o+aa7mXNo68UQ9gxUnjGeFGP0qx6S/0Gizmk
         Edjy9oxEBLT1yxJjU7D/JhhTSXvSQguj8Bdoga5ZXuhj2N2Mvt9MPAel/qRoznskvJVm
         7uNOJUcCRUC9LtV69ZMdqkL4tbjrTmRio49xt9GwS7c4UnqyPc65PsD8WBXWHjUvY2Or
         hCtCbGTdY4By96YmZlqvDtuPUmF2+npfYhrHoiVnu/AmHQTM+d2hQR5px7OkEP9QxK6x
         bpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731020284; x=1731625084;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2mUQAjp4rvZTtEi4u2daxcIxqByD+sMw3XpgzGgrqQ=;
        b=HQy3dKYo11PpV5bPAK+runf1ZHn1ChiSzJQEBhy5ACXLQpc7Tvv28+HqwHLTA/DkB3
         aUPDEn6tx6H7bAMoXGQSTN8g9+gBQz58LWCrlHy8+3T7cB7fOn5CmvGQq7WvmpocNZwK
         D9TkAIPSLyxiwlDdBr5+Am6UuSC7tQedQ7ZWVhGKVsH1BPdadeiG+CWXxbJA66OaRN2a
         vJ19JVkE5BVtvuyTt59IiCOyFuXjWjx6eSn3dTrtQeEZRwNI+9nYbCSM9Ti8/MLgC35X
         5Z8s5R2dyRvDuBeom7OTQv3Dd0uJFacM81kaL5DpiGMG233fdLmXR791OQ3pzNfXJSpA
         PT1g==
X-Forwarded-Encrypted: i=1; AJvYcCUtkKCgTwaWvirY/SbZSby4Nc99uuWK/bpTgjyMdlHTPlTd5A2pPR6B1vzli3VByQ2ucaONkfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLma8C/Ovh2dtYrpOLUATALUlcL484a3RuXGyMI+Lo2zYmKkx1
	VA4zzap9jj30ZQAaziVIiUyQcmIdNrqrQ3Rm6Wv5A5jd3LvJdPNK
X-Google-Smtp-Source: AGHT+IHNKaiPOi/tTdwPxOJNDjjeeYLWM/9fMHvxuGRPuc0xj3im+EmDwE3ISoHb6bTVpACztxVE6g==
X-Received: by 2002:a17:907:d91:b0:a99:f777:c6ef with SMTP id a640c23a62f3a-a9eefe3f416mr48402566b.3.1731020283910;
        Thu, 07 Nov 2024 14:58:03 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc57f4sm153398066b.129.2024.11.07.14.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 14:58:03 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <7c4dc799-ebf6-47fe-a25f-bb84d6faa0cf@orange.com>
Date: Thu, 7 Nov 2024 23:58:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Jamal Hadi Salim <jhs@mojatatu.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: edumazet@google.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <20241106143200.282082-1-alexandre.ferrieux@orange.com>
 <CAM0EoMmw3otVXGpFGXqYMb1A2KCGTdVTLS8LWfT=dPVTCYSghA@mail.gmail.com>
 <CAM0EoMknpWa-GapPyWZzXhzaDe6xBb7rtOovTk6Dpd2X=acknA@mail.gmail.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <CAM0EoMknpWa-GapPyWZzXhzaDe6xBb7rtOovTk6Dpd2X=acknA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2024 15:47, Jamal Hadi Salim wrote:
> On Thu, Nov 7, 2024 at 9:45=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
>>
>> Hi,
>>
>> On Wed, Nov 6, 2024 at 9:32=E2=80=AFAM Alexandre Ferrieux
>> <alexandre.ferrieux@gmail.com> wrote:
>> >
>> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> > Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
>>
>> I'd like to take a closer look at this - just tied up with something
>> at the moment. Give me a day or so.
>> Did you run tdc tests after your patch?
>=20
> Also, for hero status points, consider submitting a tdc test case.

Hi Jamal, thanks for looking into this.
Just posted a v4 with a tdc test case.
Of course, I also verified that "tdc -c u32" has no regression :)


