Return-Path: <netdev+bounces-54229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE7380647C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACAD92820B5
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 02:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F71538A;
	Wed,  6 Dec 2023 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEeBVdqA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1058ED46;
	Tue,  5 Dec 2023 18:01:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so68416355e9.2;
        Tue, 05 Dec 2023 18:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701828085; x=1702432885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CveSuDKNEmS9rS9AA+dffOv6d9US39k3LhBUDbw3Lg=;
        b=CEeBVdqAYWUDdO9dTHBOjZDsXPV5jTjfieI1NcgseeeteKXgRl+z1R5cfyyIGO2euL
         Z3tz5GK5LFjglxV5405FL+fkWtL/O8W18mqfqJvw7OXsuCQLp7EQcMLzaWVG33J3jtjc
         JxvgEj39S5UC3/OjP2VIhePb00+CZkJA9fJddasbQlU0KJXNzy2UrWet1teQkbusO5Pf
         3TSlWloVRh8gjvY9zSeQaDfACHMskp4IFwST7ZdujViwyh8h51g11qD4E2S5DY4+1O+t
         qZJPj4LYL21698FEKBaQIHOc8vnrOhVUDe/zQ9TC25MkP5omvfKWECJqWYWVlw3/Jpmw
         dqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701828085; x=1702432885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CveSuDKNEmS9rS9AA+dffOv6d9US39k3LhBUDbw3Lg=;
        b=fA2MzmeEid6eL5kiyV+cWzR40k92ddClJRbcBLE4iEaxijycNb6VAuiYIloB7eImFu
         Y7AyS/Nckk844fZ0OD2MiFqbfr03ZImNIAiwZUE0sAv4Z8qXMRfUt0bxCLmGEU80eSma
         mUa7I1UA1f4hUZ8jcBzoES3a92wv5knUzmA/uuhhsT10wF+3O8KSraKQcfumJ8JEoaO9
         jJJVUzjvU4B3TARS1fgiaZVlZvmmP4BXuBnNPBANbk8M007cvIBJNBJLDkJcJqNW/vvH
         7i7fw4d0wkSgxwSdj2ebHnFCZKXlW+VHwQ7veh0VekOc+++X9Ahz2I6Is6EKMlElnVUt
         AgCA==
X-Gm-Message-State: AOJu0YxLttx5TJl+biiyVPT2rA+7Ke9cSL1s7SrX3oLRmi7itA/fJXMC
	pWT1RsuKpQLixHbWFBj3oIMpB4HH+8KDiXvrIbg=
X-Google-Smtp-Source: AGHT+IHYGNPiTGuasVHg0mMnl0dS5kxoiCSp+smWvlJe9YQTX83rDoIR0gx5HSbFIfTmTJTxOsxGmjdG43boWS2khy0=
X-Received: by 2002:a1c:6a0d:0:b0:40b:5e59:99ae with SMTP id
 f13-20020a1c6a0d000000b0040b5e5999aemr75739wmc.206.1701828085148; Tue, 05 Dec
 2023 18:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205101002.1c09e027@kernel.org>
In-Reply-To: <20231205101002.1c09e027@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Dec 2023 18:01:13 -0800
Message-ID: <CAADnVQLxBzv16rRjCoJHKc+T8gRfw5PZfZ7yZKCCYPP=x4cWLA@mail.gmail.com>
Subject: Re: [ANN] Winter break shutdown plan
To: Jakub Kicinski <kuba@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>, netdev-driver-reviewers@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <borkmann@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 10:10=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Hi!
>
> tl;dr net-next will be closed Dec 23rd - Jan 1st (incl.)

Just wanted to remind bpf developers that bpf-next is always open.

The patches will be reviewed and applied as usual.
(maybe a bit slower during the holidays).
BPF CI will keep testing, etc.

