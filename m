Return-Path: <netdev+bounces-85042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65658991C2
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 01:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BE91C21A05
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 23:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FDF137C24;
	Thu,  4 Apr 2024 23:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEHp2AMX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38625286A6;
	Thu,  4 Apr 2024 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271905; cv=none; b=L2kV4C9awpO8bRzQE8J2iF5AXzo4Wx28p74aglQXQ9sp+rhvZXpccmKFF1q7viVxBj10blHK84UkwSd+1cf/S8NAV9Jkcnl2OoDEMOqXszh3B7iNTppk8H76HZ+L3cjbMo7r33ymzsouHnc9MHMJMsnU9Jvhe2YdSJkL0vJZQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271905; c=relaxed/simple;
	bh=C5xxoPV5nrbzElIC5AjVzI2Exyd+dN5mk33ceMxxV9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcCMoPvLfKwTFKGL9ANNv0Buu/86foXvS7HzRVvVY4jfsbWNeUM36z00LJbPmrQFKmQGWp2xaFuPNBBHC5xqvnTZdKcZhNVzqWRQp5TYjsLbdoRNhIzUxW9NHYF2qArx5T7PZbi6g8oSVDCjcy1dJkd+IzG8AGCD0a3jJVycW0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEHp2AMX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso968045f8f.1;
        Thu, 04 Apr 2024 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712271902; x=1712876702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5xxoPV5nrbzElIC5AjVzI2Exyd+dN5mk33ceMxxV9A=;
        b=EEHp2AMX/dbyjmt6kFKLGCCJdPKBRIW+3n9rTD/aReaIf69I90JRr0dH0rw3H7v2A/
         61AYMN3YYl66ZOFS0bOGzq3gx5Alhc3DyNA6MKBELtIUjjrUvYyEowVlCGMzbKaAes7x
         kklRifE8l6ZA+4a880ez1ZbruvSvS74ULIuLjq93MMx8yVe1xUd7+uxSZLYeghpodC+y
         66KiyCQcQqDHuwxZaZ6AjdQcNmkGxfAJ5I7Ded1whOnkHiQsONP8ZIOYv455cDcgZoaC
         XPD7PpZOX7COTMXaJCwyc12ijXGY8BbzOt4QBTa/CvevqlGaAHO2HxYYixLCOcrv7iDL
         WRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712271902; x=1712876702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5xxoPV5nrbzElIC5AjVzI2Exyd+dN5mk33ceMxxV9A=;
        b=DDFQZPsem1esBeM5H9tWqYwL04/LDDz84u1vJW99XUCRd0rdFvwasKjb7RPJ6GYlwM
         NH9W/Wm2nxyx1Qoa0ROFNJVkHL8+aFIouqgjpEqQhmp5fGq+W7imZUmH6KXiwjCgpmtO
         ZV1JqHr0VBxhVmV+BNLLloLhcxhsp+SGJVhvj6Viusqhhg117h8fmuJHAFIKqC0BQ7x+
         MYphm6SSa7eJC2m5RhgBj3ieiXsxQ91A3fZg4md0gqAVN/1F1eG0O0hEfEYuHMPAU6CN
         9r7tE+4QauSXug+LB0njeGX+WsAB9uVuaj1XWUcdGufw/gDZE9264GyWMTUxz0hOfQmy
         sn5w==
X-Forwarded-Encrypted: i=1; AJvYcCXDEy+MYXuMqBNnwB1LH+hwECAwmg4JNchsGBN/xxeuJDXpwJcrvsiq2lQ8y3KLqtWpcfUHwsPh9Xt/2LnXxEe9fhBk
X-Gm-Message-State: AOJu0YyQb3ieds1a9PiVedF9M/70ah4huClMoWz0ARAi23N8E9lLXYPX
	wJNLwYuhZTPbPgoNuji9wKarg2AIpd5Kc9DS9OzIyZ4r/iBbMngW9l+oIIu9vWEagV3XKILcFjt
	znba3y+IViiqTdqjpBY7DXdmGyu0=
X-Google-Smtp-Source: AGHT+IFSygVOCFfEebpKdZxwm4g1R5aItVFIvLvXWc66l9Fxbkv7yc4D0JIwEBAZuSnCaVbjrHzTHO/bHw1BKfR8wVM=
X-Received: by 2002:a5d:638d:0:b0:341:906c:ecd with SMTP id
 p13-20020a5d638d000000b00341906c0ecdmr607410wru.11.1712271902293; Thu, 04 Apr
 2024 16:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122338.372945-1-jhs@mojatatu.com> <20240404122338.372945-15-jhs@mojatatu.com>
 <CAADnVQLw1FRkvYJX0=6WMDoR7rQaWSVPnparErh4soDtKjc73w@mail.gmail.com> <CAM0EoM=SyHR-f7z8YVRknXrUsKALgx96eH-hBudo40NyeaxuoA@mail.gmail.com>
In-Reply-To: <CAM0EoM=SyHR-f7z8YVRknXrUsKALgx96eH-hBudo40NyeaxuoA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Apr 2024 16:04:51 -0700
Message-ID: <CAADnVQLJ3iO73c7g0PG1Em9iM4W-n=7aanu_pc9O0t4XrG5Gwg@mail.gmail.com>
Subject: Re: [PATCH net-next v14 14/15] p4tc: add set of P4TC table kfuncs
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, 
	tomasz.osinski@intel.com, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, khalidm@nvidia.com, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, victor@mojatatu.com, 
	Pedro Tammela <pctammela@mojatatu.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 3:59=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> We will use ebpf/xdp/kfuncs whenever they make sense to us.

In such case my Nack stands even if you drop this patch.

