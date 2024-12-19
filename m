Return-Path: <netdev+bounces-153380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0FB9F7CDB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD074188B25D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F317224B04;
	Thu, 19 Dec 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX6cquNY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF5224AFB;
	Thu, 19 Dec 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617550; cv=none; b=t/nl11YE7RoOo3A61PAyJsUS4OqpJXWceCD9m35YpPAFIjsA4yFA0sGuF+CUNlS5/RFzg8RN+iHMvi3JSZT2qJa434WKZnDIWM/JKVGWMYWQCVeykJ8IMc+/5RjHb5ab+b7YAoI9GxV7+Zna5H5psWY4gOveEJ8iE03kf1h+2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617550; c=relaxed/simple;
	bh=zISWZ0fw+CqD6ydnZ56bBdexKG7yNP8yH4DCvgzpLCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLmj63F7bQhEf37tWegkf8QuwVBgUUucsFsQjxF6vllrgCcdrxddE+b4PGbqgz2fepAlmf7peMD8S74fSEUaeST+3/dXyhI8400kGLxqZKLYbJyEGTqA4kW4g7yKeY3QySuNetcF7Zu+yU58tMo78SEDWPRwSVTzXWdBjfz82qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX6cquNY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so1229883a12.3;
        Thu, 19 Dec 2024 06:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734617547; x=1735222347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RJgd19IhjjfBUj4/+02O2nhhZfO8rpLeVos7OC/i5s=;
        b=WX6cquNYb+PufYuC5nH3Oz9gDHr1TIerDatO2aw2H2EcUUcEwjYF8iFEM8ndW8uBco
         zXW5KHAs9AJZHZp5uG1TRAipDZ5IqgkkYyQH7a10FQqBgEgMKDXd+Gd3rcKmKyXqxfVC
         w0tZq6dCEVwS5ShSppTUfLc3nTBHEOxpie8NeJKFCEwCITfKHn3dRJ88GVXOPFLBcmRe
         FO1Vdo+TsfRQ6cX6HJJS6bKGt0DIaDj3oKvP/SyiHEGasd7XbPwOPLxyAGwPXIedtJ0v
         5nEo8W9t5Ceke3SI+axhtuWDpUs4725RzNr4rHeMrPc61vyP1QMnXNpTnJLnCJoORb/U
         kaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734617547; x=1735222347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RJgd19IhjjfBUj4/+02O2nhhZfO8rpLeVos7OC/i5s=;
        b=tUAOqV5D00OPPTUdwqIUOoRb8J/dcnHU0yEoATPS2mAF/t4RbkhkvT9RcL86y4H0JU
         jZc78JVaDOfX1D3sFvcBYrEMAIwnmjUkuqWiIgEodjIocZQ5vC4JtazAc7m+QsA9dd1A
         fc2simuJhDU2MfYu+yVdx2S9cXddjPGe9NycI7zgJFuIHMLzj2lKhznvEY1CrYgS9twY
         p3RpIRFnrOBFZX0BO94bPfwy8wtLS6+PmZWinzGZ/XVc9UcVZraKYcBV1f+eusqBsLWP
         mMViROYiUdI718W6HUxm9Pmyap/W7+zhaqT7DdReh3e9V+d3syA+25oDY4E9fGUzE9ba
         WF9g==
X-Forwarded-Encrypted: i=1; AJvYcCUBGbWPNkCksBNaIgkEuTf6vMDw4S1EpKYUNHAmUEPy94nmzrNJWNuMYRcpwtquRbxzUWuRD9F+@vger.kernel.org, AJvYcCUL+0T64D0z4GXwW+aK82nCeDi1zSNVAflBnJd/wvaOb9fcnbeF9gh3XC3YW/TLCM3Wjte77U8wwOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoc2WwcqwC/ka8Kb6Iqle88DoTw1GCA71RQYKM5vY7Y7+a6ho7
	RM95r9/hyBwT3b5vmmV2yV7+1gEdueYidZUcvVuE1u7YhqNL/yu6gzq9QYQvJayUhH3E0W5Ow9E
	+y6Bw3heUjhF7aYKftjZdoGmr8wo=
X-Gm-Gg: ASbGncvHTGvhSbjFX27SOn8uAlDnT/3tPxn0jkGdYqKCNSPoBvw65cKFNaK9FEMy06o
	FcjZt2TWp7wJC2qQiCp/38Ik8Qpk3Z+kXtDVx6O4=
X-Google-Smtp-Source: AGHT+IGxrtupuLBU5333cgazCo9lwEMsbsZ8wJVbQuhJSb4db/nw1K11C3TREBRC7lEJkixLCdSrf+UwcnlZHJsvbQs=
X-Received: by 2002:a05:6402:2805:b0:5d3:cfd0:8d3f with SMTP id
 4fb4d7f45d1cf-5d802661e91mr2852600a12.24.1734617546854; Thu, 19 Dec 2024
 06:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218144530.2963326-1-ap420073@gmail.com> <20241218144530.2963326-6-ap420073@gmail.com>
 <20241218184000.54831119@kernel.org>
In-Reply-To: <20241218184000.54831119@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 19 Dec 2024 23:12:15 +0900
Message-ID: <CAMArcTVdrQVous6XPVeU-k0oYZw2NkVJup7-gQMvf+7rR3fkBA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 5/9] bnxt_en: add support for hds-thresh
 ethtool command
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com, 
	Andy Gospodarek <gospo@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:40=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 18 Dec 2024 14:45:26 +0000 Taehee Yoo wrote:
> > +#define BNXT_HDS_THRESHOLD_MAX       1023
> > +     u16                     hds_threshold;
>
> How about we add hds_threshold to struct ethtool_netdev_state ?
> That way in patch 6 we don't have to call the driver to get it.

I agree, it looks much better! I will change it.

Thanks a lot!
Taehee Yoo

