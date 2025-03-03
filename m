Return-Path: <netdev+bounces-171277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6584A4C559
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F88165383
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B40190468;
	Mon,  3 Mar 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK4nVNop"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00513C3C
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016148; cv=none; b=dij9TLkEctuoBRk7tu66ni+23NYbQEUDhqq3Wwwlrl2ucKfGdL+uEHt6RTfl/WJo9mRuBm0AKV1sm+ryCwQDum53a9DTM/cmqkX5CFm9vsyQ9BNxdM/BlTaBmXxajIT9C+xmHqtzaM4P3p3hj89zuqCHTqTWjWPyJSO1o0Yjyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016148; c=relaxed/simple;
	bh=sYYa7N5HjXiHeRdNC3VrLZakjw8ZSG68U5G2oFhyGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maCWMV3vWHiQHdsup/374hdWUGy+yJqf+pJr5YHLFLh5An6iFBtQIbtOrSZiF7cCyfaQfrMx/O9lthLBYEnOq9xx/pYOShDyqjbJRYwU75LIbx6WkfuC1uD1QCKxS8f6zr1nZdMJ1BLcKkMGyK81cSkNt83bxPB85es+A16C/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK4nVNop; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223594b3c6dso77898725ad.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 07:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741016146; x=1741620946; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2bRICBq4NMgqqwML45f04cUWAtX5yOZGH03e3r5ua+Y=;
        b=dK4nVNopnsi9L+GuE60GMcOLnL6cWiqJdU6BOToDbvf214/Iw/r7D/y3r5UYtYgJLY
         M4A2w9JmEP7caCxxYKzabj9hI6b9s871i65ufRBjXNjpCWe9FuBP3J3MVZUHObLKF6lp
         4tD6zDWwu96fXKoBZksmP25b/XRqz/QuUmR7w0XkroTRddfEBW8g6Sw8blt/od6MTSMb
         mzojalz5M7eFrqxU/HajCKSpPyEzDUASYeXNbAOEG0XBbYMbNRmx44WA4oyfWOxMq3k9
         sQDCqtStQFRmGOMke2r1uHGALo49mB2aaQANs3+gIR5GxFkzwrkYElWtmEwL+VQ0eQut
         zlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016146; x=1741620946;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bRICBq4NMgqqwML45f04cUWAtX5yOZGH03e3r5ua+Y=;
        b=sQnylFgTFQNXHLOGwNL741SffmmyGcWdnWTkorXT3++hJ0ywIshwNflnDWV+ShUX6s
         Z4BQvx6cHvSQrfPW6ACD/xIJIha7x6ohvyt7mGNEad3mA/IIs1UaW1HEPcUKDAvdQO61
         ksU7PLaCED6HV/qqrDLqP7las/EjeUPWcj2ukiTtvmc+PTXg3UZW3+PaEKILJmxDsq6V
         D0Cb5/iCu1TxmafqtEslZy8cBZsliRD23IQdMeY6vG3G6va6suA2+9xd8zToBf3j4AkT
         LEIlFZIqYfXk+r15n1fg5uSIyO5ZB0yhKUzRwLW+f+hAUn0/ekRO7Ae0KHKxuXkBNgki
         7JUA==
X-Forwarded-Encrypted: i=1; AJvYcCVoykjpCAdcQy4y11po8+2fV7HwmOl1Y5gtVbAUyyd3qSDXJBBn4EBFrENjbitd6lf5tQJY978=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ctOoU8Uxdmiyn6Csw0PkbxFmzQ9lTn7dcwKNuyA9XFgXegkJ
	57kQm5K+Y225tiQ/ZceGYaD4dXwQCKbzzoA7iNoQ5Ad9u5+h6go=
X-Gm-Gg: ASbGncvDqt/ZXgHjcS8RVHL/m32WODq1a8Gr4UfhymQV9WB2USDuN+lp+UwXTEZ3u5N
	QvP75QEHJupPYN2XWnzW5ldz9/LTY/k1U1ml0IpG4A2ZJ63/eESmfRWXOi7Hen2hxVVGQas2gv0
	4OJ63fgGwq6gft8v2VkBD2DAjFrNrEyiJp19ReXdAiB+woQijoa9RoWZ+jU7fecJPXk3jSkt3Y2
	LltWJxYHO9YB5IZjurD2OsaFQUB84M70mtwXkHY3uRnaroTTjdAHwXIFDyvdNNj7sFUij9pZOCQ
	mG17MZIJS78AyzK7aXhp3oeQoC/kM9XrmWGqI/dHau4x
X-Google-Smtp-Source: AGHT+IHblmg1fFpop4ZsnCL2Lq4RlIn9HCcwR9AI9yzYj65Kd2sx5wkVb8r6TeD6TdKSXZZxQLTm3w==
X-Received: by 2002:a17:903:32cf:b0:223:517f:94d1 with SMTP id d9443c01a7336-22368f6d20cmr176201235ad.3.1741016146209;
        Mon, 03 Mar 2025 07:35:46 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504db7a6sm78495975ad.160.2025.03.03.07.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:35:45 -0800 (PST)
Date: Mon, 3 Mar 2025 07:35:45 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v10 04/14] net: hold netdev instance lock during
 qdisc ndo_setup_tc
Message-ID: <Z8XMUWqZT_AiemQz@mini-arch>
References: <20250302000901.2729164-1-sdf@fomichev.me>
 <20250302000901.2729164-5-sdf@fomichev.me>
 <CAM0EoMkj=s+0G7AkCBdgBp5vM3xhusUpuX3D+oQZL+hWPFSJjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkj=s+0G7AkCBdgBp5vM3xhusUpuX3D+oQZL+hWPFSJjA@mail.gmail.com>

On 03/02, Jamal Hadi Salim wrote:
> On Sat, Mar 1, 2025 at 7:09 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Qdisc operations that can lead to ndo_setup_tc might need
> > to have an instance lock.
> 
> Sorry, havent followed this work - "might need" here means that
> sometimes it may and sometimes it may not need the device instance
> lock (I suppose depending on the driver)?

Yes, depending on the driver we might grab the instance lock now, see
[0] for more details. One thing we might consider doing here is to
grab instance lock only if the underlying driver uses tc offloads
(has ndo_setup_tc), but I didn't want to over-complicate things.

0: https://lore.kernel.org/netdev/CAPpAL=w0+x1Mj3iHRkeiktXjY3FTt-pz9qHk9f0KF-EL2FOCxw@mail.gmail.com/T/#m76b928e4adb87aac30dda7e51b331712a3c0c2e3

> Since i dont know enough about the motivation for the instance lock, I
> just reviewed for consistency and for that:
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

Ty!

