Return-Path: <netdev+bounces-56376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1ED80EAA9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A3E1C20C9F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4477A5DF19;
	Tue, 12 Dec 2023 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsavdGZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A051BDB;
	Tue, 12 Dec 2023 03:42:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so41779055e9.3;
        Tue, 12 Dec 2023 03:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702381373; x=1702986173; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s946wFudZx2gMy+LiIFH3bnoxj+kP0rKbDs7VyND60Y=;
        b=VsavdGZuxK2jl1zqOAqqGQ1ID+V/50ZP+omd9bjbbeuDa88woPlqf5YNwEIM5zBLL1
         dP6qKu0joIqbEMsf0zTUE2rQjvedyXGgxl3p1Ay+mV0n8vELZVPa2qRqRqfE/+yI0bDc
         u7vicQZ9pDiEGr8ymi6ecsdsKpI/Dz66Sj4/9UxK01rbTG1bOM+sLxxwemRhu/W/KL0H
         f1GjQ0qmBHZ8QqAgN81LSGbbk2WJ81bZTaUqyCY8+//7tcu65lg1fBxDRH7PdRYKaAGJ
         olIMIMgFfS/4bkhgrMeJALpDmUkG5hIccA2OyTVy3Vxwl1M0CPCuudsKG/pfOwnAWXBr
         e1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702381373; x=1702986173;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s946wFudZx2gMy+LiIFH3bnoxj+kP0rKbDs7VyND60Y=;
        b=jT78WtZVxIjlXgdeIcYTXP4PtpT3RUSVdCZZMiSD5O4Hw07dZtt49B3GXWZ/4IKlK+
         K49mqIlqDJz9tWGLu9yZ3zcL7jprqGJT5Zwjhg/QZ13dyt/p3H3AQRGRDTHSexmtay5C
         OFHeuigS/Vfi2bfkc+b+PpSvzOu8wryPFMeUuI+5GQsBvCHy8xqPy6DvmxlAggeODTeF
         MeXeflbfSgzK7nmel2SLUE7lYKeZTyrgyiQ2vAMZTWC6Ph5I7ra4Tt/I1JfOPO+14lel
         PVK1SvCdhe4uZNz7NyMbKZt+TjqNCA/NGbb7cavJD6fD7L4OuylzX3fSMeg242+HxvT5
         7Ghw==
X-Gm-Message-State: AOJu0YzVWh85IkOnmqY/ZyHQQAn+Lu1my4eW22KLX+V4y46hLbjFN45l
	jcKCUocL/HQGtLGlhwPJpv0=
X-Google-Smtp-Source: AGHT+IHkA5vQDocC5GwWTVxQGReNavGvnf+tn4n9ideJdb2UWpEnJf3+XIb6cgS2KDqpqGsHOQS86Q==
X-Received: by 2002:a05:600c:3b8a:b0:40b:35aa:bfdd with SMTP id n10-20020a05600c3b8a00b0040b35aabfddmr2718721wms.27.1702381373046;
        Tue, 12 Dec 2023 03:42:53 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b0040c2963e5f3sm16181574wmb.38.2023.12.12.03.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:42:52 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 05/11] doc/netlink: Add sub-message support
 to netlink-raw
In-Reply-To: <20231211153743.298f9821@kernel.org> (Jakub Kicinski's message of
	"Mon, 11 Dec 2023 15:37:43 -0800")
Date: Tue, 12 Dec 2023 11:30:59 +0000
Message-ID: <m28r5z8xos.fsf@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
	<20231211164039.83034-6-donald.hunter@gmail.com>
	<20231211153743.298f9821@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 11 Dec 2023 16:40:33 +0000 Donald Hunter wrote:
>> Add a 'sub-message' attribute type with a selector that supports
>> polymorphic attribute formats for raw netlink families like tc.
>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>
> nit: I tend to throw a | for all multi-line strings, I either
> read somewhere it makes YAML parsers happier, or Rob recommended
> it. Don't recall now.

I'll fix that up in the next revision.

