Return-Path: <netdev+bounces-185671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB194A9B4B4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2932E9A72E0
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C67284683;
	Thu, 24 Apr 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQDxohou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30941281529
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513600; cv=none; b=NMq73Gnp6+0WVMiPGpEuefgWNk8MYa/OWliKqcls5depHkZCk6VBvZdcnh5bKeABcuiJvG9HLY9x7JAcEDZ6HQUOdgMO0fz+qdp2aCGK73LseVrmOiJrxN39C8QIsaLyvxBuOaCcDs+koJs1y/Gaej11xFd+Ud0C5niKBH1HZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513600; c=relaxed/simple;
	bh=BtDZ/uOAPNgdKD05LE8UeBHthyMo5FZqHgOyzg4/5/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr6H6LcC7y+FrYWmyaWSe75vDOoaP4fz66EIjDGARTnj/dXS+B7WJ8hLSSpI8kN96krft4nuyeUSJSwnBNbbP9z8DaCeWR2g1PEELBxeL9h0emVLfw0muLEobt5xaGTiHwq1ja6kWaUrDtGZAxPsEeimRWTPyzqvQKQQFbogJvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQDxohou; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476977848c4so15791941cf.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745513598; x=1746118398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtDZ/uOAPNgdKD05LE8UeBHthyMo5FZqHgOyzg4/5/s=;
        b=XQDxohoutJK7XdioKx7FtWeUxk+ZsRZ5UCXMIAWywktiaKFyDeFK2eALtBFXF8CV4G
         XwKhFddxAZRfeWHmWWkhVfS16XkbmYXwVoIKID9EzAgmBjtAM0jQ7ZyAoBT2WlbYAG6H
         PQNObWIKkATGfjlCTO4HvE5xfy5D/27plIKQC7kWcYYV6vTedRjz2wlzC8S3aSt8ln/r
         f1wM+XyYftUOJD57X0t80epuzT/UUQFdxxfQT4K40Q5vb+9cxxsm1Fz5cOuZG+2xa5qa
         8/8NNV8nfDSLIULhPBqiRFbEOTGO97a+ZXvkeorver+0mppUx6MGzaidKjI1BYMmp+QM
         JMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745513598; x=1746118398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtDZ/uOAPNgdKD05LE8UeBHthyMo5FZqHgOyzg4/5/s=;
        b=RqBJulbvmoDwdoGsPHbr6WoI543PcnONriZ1nITtPR7bnHk0rtOLGj2bOSxtEQDrmz
         i8NhTxfkxaEMcG11BMT1MIQbq6Kgrx5qkj9RwT7CfbjsLSBQwfItQrax4re/Xfo3iKM6
         pVC7pg6Whny05q5qmLdUAvOvdjLRcgRnVdJwyulEmSXbHrkvI0pCLe8BlMxAaZsAszBi
         Dkd1uCkeXZ1eVYBwNCIL1JfKsxPCL1j3I6UWsCOD8W22TBM9zfo5xF7Jb7jYyZOiDSy+
         DaRYfTUDH4bUCSgDmor0Mq84aWwsbiYZB961B1gUQFWD/BAsgk8u3M8M0JDr7L7ohear
         g4KA==
X-Gm-Message-State: AOJu0YxlPpffnRqd2/1uqCGhM4tHsHVO54RNFgF+BObLmPa++QC/nuiC
	CHEqsHv48oW6faDXu+VPwWtKa0h4LLPh39aXaW9Bb8mbrSuI9PSq9S593xh7U0jkD4yQvoSC5eN
	RaE0Cvb5B6KB6+T+IuyeL71yuMjuINUYy5jTp
X-Gm-Gg: ASbGncs+ku4WMAxLAVNVnVieQOX9G6002RYAR77BZ2lUxwWzCpguBCMETHLHn+5pAaM
	Rp+Jfs2UsqeHj2j/n+Kz1VzNPcFHfqVciIOS05sQq+uY/QBgOm8WwpE30LuYDK5jBPGhF3fGKEm
	SA+vhbE3GIxAPThwpYf+U1DgrEoiJT6SdakeMeFsmVzE9WaKmJAQI=
X-Google-Smtp-Source: AGHT+IG0l41A626LjXWPw2bv29zJO4YzEm9zskSprdsGPA8voum0ytqo5LTa/JAneLe2b3Nu5YciEb5XckhRns3Deyc=
X-Received: by 2002:a05:622a:1a92:b0:476:8825:99ba with SMTP id
 d75a77b69052e-47fb9bd6d12mr5462331cf.12.1745513597777; Thu, 24 Apr 2025
 09:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423124334.4916-1-jgh@exim.org> <20250423124334.4916-3-jgh@exim.org>
In-Reply-To: <20250423124334.4916-3-jgh@exim.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Apr 2025 09:53:07 -0700
X-Gm-Features: ATxdqUEKRXNtaj5prXssaz2nuXK1JCOI89dxT0q3IKQbXxmHJaCgSoAxoBJYsqs
Message-ID: <CANn89iKCwxJrF4y7M34=mva_Z1-+UA2YwgD56MBi+3_YkGxzZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tcp: fastopen: pass TFO child indication through getsockopt
To: Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, ncardwell@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 5:44=E2=80=AFAM Jeremy Harris <jgh@exim.org> wrote:
>
> tcp: fastopen: pass TFO child indication through getsockopt
>
> Note that this uses up the last bit of a field in struct tcp_info
>
> Signed-off-by: Jeremy Harris <jgh@exim.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

