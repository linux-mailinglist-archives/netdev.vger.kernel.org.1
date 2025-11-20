Return-Path: <netdev+bounces-240224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D002C71BB7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 02:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id F15AE29B99
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B1C26657D;
	Thu, 20 Nov 2025 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEJSHFJf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0A1DE8AE
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763603669; cv=none; b=RiznKLoZj/KBZIt5AA1LrST55LNsofc04idhE9YYjTFySSBj9DyjEgNMqtujgYF1zYvGlc1u+kh3qZxlg5K81aA9E3RmlI8DPhh/wSbXabCHFYxKb57Iyrdq8pqlQkZEriHufbX2Mj8UV9XZdQNOE8oq4ub7Z/37lxFiWIaXjp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763603669; c=relaxed/simple;
	bh=MFvDHRF3d5FB9PKU6LXkmJgvlUEZr0HeuQ97CnYKPac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VR2gFYexbXa2yHXr257HM9l/3tWtrgqTGkW1rVvUHfF8DLseSU/AYPBTaSS6RxvIkYKPWX626hCCX+H8DR8vlrjDtlRN4dzvIWaybtWjg2N9Q0q+GqgojOaXmJw0PWblybq+FvNS8hyJU7ZpR4JK71mt3Oyw8vQBiRwoE0c/bI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEJSHFJf; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-434709e7cc9so2127805ab.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 17:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763603667; x=1764208467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFvDHRF3d5FB9PKU6LXkmJgvlUEZr0HeuQ97CnYKPac=;
        b=fEJSHFJfnvJhCRNsErH7L5e+xFMtxmvbem7AdE051tsFvMKWDNPwZejEUX6mwmYXGU
         E+ZGsx8j7tpX2iz2/rfpbh/WvXNh13C4B8M00kN0OwS0tK3WjQgXNF2vQmwc32S9jj28
         9uZVsCEnUh9aun84I8k9omp5+vHV/43pF3tHCGpE6ZO77N5y6yKYbw2K6sKi0sU5NEoM
         Pd+ReNvU97gowoeVWL9swPvelVf/s4AjBV6oFnup0mWA9lAtlAmbn09fmwKbkh0MaPRG
         xB9CwamaPjJY+1BOFlWKj6h1+epvJEVgNnn74gUQXJct3quQShvBqUerlXgZMK//LlPK
         qBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763603667; x=1764208467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MFvDHRF3d5FB9PKU6LXkmJgvlUEZr0HeuQ97CnYKPac=;
        b=W+5LBG2/dQwk68NnKfcsQ9icAyEVBuUvuB7eJsJFQx4Iyy6UdADHnuwcEEoIfUmJ+Z
         2IKdMi0Qp8U5nJvgKRNFwyvoE5462DuTYGroSOl8gnBOBOs7ZDONduwwTLTkmquBWZsf
         opE/XxkQSnK2rF0LXu1+jGphAHJpO+C7r21ROFgRkI61/H8PfziNd61Hyrskfjf+r/+C
         F6JH2XdsBWFOjdQtbaC4CCivm78sUt2PAeAYS4/SokyLcXJD+LUm+1MDTfcwkr0xrrr+
         IdEFLzueXNykP7atC1vGa+1JcAsdkkGd1eQ8mDDxcAXNJ1s/p622ts1HSLIWrw4nj0/K
         i5ew==
X-Forwarded-Encrypted: i=1; AJvYcCV5TNyLSUWgeLDYlxd/RRM+ldPveQahRkrrZdg1SuXI2RmJDD561PrAgCk6Rp+72ekA5LwQ1gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQ/CmoxQZVxUD1hyV/LIpvJ74aUitAWm9DIi1bearcewKhBjh
	LevSup3+EMOnAAheRilvrNtKS0KlABFTJTig2XWJvIAj4iD48biY7Fv+liqo7fq0RjFAiZR8BFc
	oWJ6Wh3ZRMtY8KrDkLUCxNAW3nksng8Q=
X-Gm-Gg: ASbGncufDI/ojYHTaCqEQLdieSIDvRSAdc1qXjwdMHoiUosAnfyXiL3rP2Jg6XfzLBt
	syFWzWwnp9Xvp9HrGi33U5O+huiVFur1Fu8nWYCShMzvXPGJGD2KCHJG1FczM2Alz3MexZgGDNm
	q6lKBGL0IxK2fKirrIKF/yuK0Opmldza4n6ea2KqgY1pb0WPDes4c0naU2Vw/j6pvP8+VZ1yHD+
	3qwWn7VrL1Bysc0GQiUyv/BH4rOcUgGsZyhJ+4SXcxQ6tbY/eH266H1cK0b0HSl3MhqXlmnb3E=
X-Google-Smtp-Source: AGHT+IFcqX1ajqVeyeILSfupP3SzSGXZNwYJDvfOdroU/r/HiyZpgaHK6DQI/9RwOKMP8kx6ejcjMrH+ZMytLMSqPV4=
X-Received: by 2002:a92:ca45:0:b0:433:2812:8066 with SMTP id
 e9e14a558f8ab-435b206566dmr563175ab.23.1763603666872; Wed, 19 Nov 2025
 17:54:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119172239.41963-1-i.shihao.999@gmail.com>
In-Reply-To: <20251119172239.41963-1-i.shihao.999@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Nov 2025 09:53:50 +0800
X-Gm-Features: AWmQ_bmOAuwXIUOZm3EqDuKTmIlqM0xlq_3Bm6d6scJyYgIVEGsJDabtzsVDhSo
Message-ID: <CAL+tcoCthG3AzW4Gs=XeWjMGYo+UoZSu34N0tJju4+0jr++j6g@mail.gmail.com>
Subject: Re: [PATCH] net: ipv4: fix spelling typo in comment
To: Shi Hao <i.shihao.999@gmail.com>
Cc: ncardwell@google.com, pabeni@redhat.com, davem@davemloft.net, 
	kuniyu@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 1:30=E2=80=AFAM Shi Hao <i.shihao.999@gmail.com> wr=
ote:
>
> Replace "splitted" with "split" in comment.
>
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>

I think minor typo patches regarding networking should be squashed
into one as they are easier to review at one time.

Please repost them as one after ~24 hours.

Thanks,
Jason

