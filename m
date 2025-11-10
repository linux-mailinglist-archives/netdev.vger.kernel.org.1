Return-Path: <netdev+bounces-237106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632BC4523A
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 07:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4473D3B1D61
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216B52E9737;
	Mon, 10 Nov 2025 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab0tfpFz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7A2E8B95
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757796; cv=none; b=ZAIRKAbmpLwTQXEXjwI5nb8+TL3HJoDcJuD97Nh94VmOkp2G2Kil8KRZx7lMxCDMFTswV+pKxTx7vF3oZhoyC8tBWV+zgdoZdmyfzbSnw9TmvAn9RRIY+G5wLC+h8Bgfsr5ynPdbT7tIGKaY/48Rv0z3XjZjuTPctiYh4BhPzQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757796; c=relaxed/simple;
	bh=1WY1CcuShlRk2we91Kyt0bCpaTxBq3s2lFYDIeGQFjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rvqEYsl3JN47iYKGANTbgFkFvwP0cR+KY+vRbkGlxeahcqblKcWHMbvji49YCNpdkpNgK63VH6CAxvNYl3JKeKl5nXuCQEaWFOjNMN4Ufw/FHSXDnmRkXqqqgSp4XkoxCU44jNhOOPTt40DbaadhFLr+7wE6H4+uuyYj8lV5jqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab0tfpFz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343514c7854so2373601a91.1
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 22:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762757794; x=1763362594; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1WY1CcuShlRk2we91Kyt0bCpaTxBq3s2lFYDIeGQFjc=;
        b=ab0tfpFz7N8LEMnO9+dPg1y9BZlC+FL7v2HxxPeRaqSUgiD1fwyw36l0SaocrFfSxm
         Ya6zMe+cc2D5+aVpvHX4wMzFUzPNQJERWrXmdTtifhSIx8gHqMBsv1X+6ZxsIwS64W10
         EVGSTcJ9atHm1GQtDGHC3DrAXu6sv98tCumDL35KcdAxeZxvxJ6hK4RalRfQl5Xry2EK
         Hyo1uuXmxMD4Gfo5G3Enr0IBkt9Jx+uVOgSukWNdSEc7bhm0pF1Fi5m1vAfx4J7q5svL
         uPh9hD43gvKbvkNSnn31AZko2CLp448PRIC/Pz0NVMOUZe7xWmYaO91yz8ddgLq1cQyL
         7JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757794; x=1763362594;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WY1CcuShlRk2we91Kyt0bCpaTxBq3s2lFYDIeGQFjc=;
        b=tR+XRpAk4Xri7s7Ao+EXBX5rXUAZNaoD7lxYCB4o/Z1GMiPjvYKcs0VlKX1rqEWVne
         OmHQHqoPMuLSnaD7eDFbJSwlubGrQHlAp2C3t8jxfua0fDoHGkFe0f/Hq0h1I74Lu1Ol
         3KR6WnfFGjMwzu19v+UY6bPmVcF2tNKvj8k9lo7CmKEpBpOqUMFIqUzGx49COeGIWvr0
         Fyt8acHpbW0FE6P/lwMy3fM2qRYlxxWaQTsOnFjeiKoeLQQGuLFjG3j6VU87YDE3sDJE
         ky8Tg6C2uXu/v51MT5YVfXxoL7yiIRFAwPWbT4evhpkDj13BqtbqMnpUSgvFfaiBOOOm
         xqIw==
X-Forwarded-Encrypted: i=1; AJvYcCVHSyYSYQQJj5Vn897Q6x/otdGcwPUw6uoSTl7gNAO39BtOGi2/4f7nszTMDCPCD/HABEJyu6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc2Glb9bAKIQ9s2Lk+FOjq/PSifsFJ56I521KRiGaKu8CxK6Fa
	qgxr3qXLNfITjHgr+rbU25NMDBZi82mSNeswTYomPfVItgqHGgi1Asfs
X-Gm-Gg: ASbGncs11kF+50SMxIYZTPeZyCeTw63M0Cx5e9Gs0OEBUI0smDu1JmFJ6DSxYtsA7nX
	WD0kuA8HLNxJORYd3MasSZ9/osFlGuIj24Zh3B8gaUkrPNeAzGQE+eiEvET39jSaHBmyr1J1T1w
	Q8JCUigZMsGeG4fP4PFLF6HBWwb1mZJfpNKZhhTehhzStdaihQVc+vmeaZ2EVwI+EJ64zblJYIu
	ch7Sz/rZI8ZQpK84CyuGfpXOqk3xCsth7EuGpVsO2g/Ydkh2AT1KJJxq7oMHRLE3toR99RoyKAZ
	WXB09zz+mqWm9Hz/zsndQF8rLcKymF2ZmdcPRXmVxh0nu8l/EMZOQ0n4c/A0l/RKBB3c4DDSAjQ
	UpgSPmeRvtOstJd9BXnIFaJ5ousCdxd7g4iTh+qfjHior5JCXHaIJZzaAxttizctA8+QYsoTnJF
	SyVWCG1GsGNDG76UpLCXIcQ0fRN5ZlC9h54w2arVdmMRByBJ7PuOOtBWfL5A==
X-Google-Smtp-Source: AGHT+IHO/HHwLn1ypxfIScvlrVfWexbtPhQMjjTTwSmPh9HSJNcv+2vgzbGH5WKsvvttQQePqFv3dw==
X-Received: by 2002:a17:90b:1d90:b0:340:9d78:59 with SMTP id 98e67ed59e1d1-343535f6b33mr12883342a91.3.1762757793661;
        Sun, 09 Nov 2025 22:56:33 -0800 (PST)
Received: from ?IPv6:2401:4900:92ea:6c8b:9820:381d:1e5e:1579? ([2401:4900:92ea:6c8b:9820:381d:1e5e:1579])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ce9645sm11854081a12.10.2025.11.09.22.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:56:33 -0800 (PST)
Message-ID: <726395fa54b40f117edc0a72285d28a70c156912.camel@gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v3] net: ethernet: fix uninitialized
 pointers with free attribute
From: ally heev <allyheev@gmail.com>
To: Simon Horman <horms@kernel.org>, Alexander Lobakin
	 <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel	
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang	 <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui	 <decui@microsoft.com>, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, Dan Carpenter	
 <dan.carpenter@linaro.org>
Date: Mon, 10 Nov 2025 12:26:24 +0530
In-Reply-To: <aQ9xp9pchMwml30P@horms.kernel.org>
References: 
	<20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
	 <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
	 <aQ9xp9pchMwml30P@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-08 at 16:36 +0000, Simon Horman wrote:
[..]
> > Please don't do it that way. It's not C++ with RAII and
> > declare-where-you-use.
> > Just leave the variable declarations where they are, but initialize the=
m
> > with `=3D NULL`.
> >=20
> > Variable declarations must be in one block and sorted from the longest
> > to the shortest.
> >=20
> > But most important, I'm not even sure how you could trigger an
> > "undefined behaviour" here. Both here and below the variable tagged wit=
h
> > `__free` is initialized right after the declaration block, before any
> > return. So how to trigger an UB here?
>=20
> FWIIW, I'd prefer if we sidestepped this discussion entirely
> by not using __free [1] in this driver.
>=20
> It seems to me that for both functions updated by this
> patch that can easily be achieved using an idiomatic
> goto label to free on error.
>=20
> [1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-m=
anaged-and-cleanup-h-constructs
>=20
> ...

Understood. I will come-up with a new patch series for removing these
two instances

Regards,
Ally

