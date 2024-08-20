Return-Path: <netdev+bounces-120113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C73958562
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FC22820D0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D20A18D63E;
	Tue, 20 Aug 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jw0BLTbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1A118C020;
	Tue, 20 Aug 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151933; cv=none; b=fz11ZEukkL/5noa/yC1pdjqTbYe78PS7p2pbtmUPu+neWrpQAEisuimMnHY7gSMDLtLItzlrJpCRcUrqwKClgUH14YKMoopBvJU+43JKQppgN4S4/Z7h3bRWXgI4/TwBeAwYNJPr5Kms3cRweiu9KjV2+b1IE3RTtb2215cFkOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151933; c=relaxed/simple;
	bh=OxCnhvkorxY3S0tJNhughjddra01+nWSPD25c6IIYFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMVmuMfwq6m/9TnnTY0zLPaTVsJC2V8SxyaTEEh+TGhPzWg/qNVn/QMR+UEAFrjBJqcWayb0/1/QK0rvvYRjQfoYkQA+b7F4lQoj9RMIsGOfznH8eie8mXFNwMfZxg272TViSa0Bzc3O0CJT4JpmVmKgbjeDriAn7rS1Up5x+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jw0BLTbz; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0885b4f1d5so5543247276.1;
        Tue, 20 Aug 2024 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724151931; x=1724756731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+n4/Jh8QBSS9BLK9hKFeLg+6zZZeNzCZQ+YqPx/qfo=;
        b=Jw0BLTbzmYrBd4p8gPYphE+DGgayTZuWs/QMujC/WxOK7bQdLaTX6AShAiInw+zVYu
         qWcHmKqzdOx3wrkes0WDOV5J2OFUA/6q7QS1H7MVm3cpI02cdqc16s0OeQnvJZo4YM8V
         A5t1TqfMZekWffCOb4bPpxf+zxpSdy1OnW7Z1zvU2q5yfZs+9fMKcyCXpDMkZ014RXTK
         HXDyF+rs6+bIX/+w4vfqx2/r5/fYzpFgwDg51SZ2z3v6ZVvLb7BooWf7jEhVWm6ax1s5
         9XU4E8Z1fUEeN+dYlB3wD0l7KmamoXUXHz+RyN5sjpS8L3CXZ8lBc0ABt/rY+49MlWto
         cPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724151931; x=1724756731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+n4/Jh8QBSS9BLK9hKFeLg+6zZZeNzCZQ+YqPx/qfo=;
        b=P2t8YdHpo8CkMV3DVA6uM7kgFEVzqZpmjFE/k4SEiIMkXlApSklSe4gSbbZrgRIxoj
         tC+JxFapGByqKNi3trDn82Y2IJsr3/NktiI1YpB9SSPdlUghCsV4HWpuX47bMZudZNhJ
         x+OithpRSFcnbv5N2brZqNyrU3QuZPDww8AtqD/uXTvYNN7HnUytWOjprsQqOg0rjVGz
         yleqr0admi98LSLFGKzS3qXVCRLpMXa7725visvEmJvqCAaKVJei7TTNPgX5k2IRBPIp
         gNdmeU72BrZFfTKpcAImxbfjHSIia16HvmyBLj61H/mtiBa0ffTBwLwfwcVYF7cNGq5N
         HtVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpUqI+y/tlHCTjWeEg87C78T0deg8LYKS+H3EQrzHiosbGupu1CfS9J4cblfi6SWSg63ZpyLWdHUAsnm0=@vger.kernel.org, AJvYcCXJJZ/O7I7YNSn5UpmBSrVM+vh1F/62n2iXaTt9GGpmdWeEFmWQHbxY+7CyuKosVWN+ylaj/uNX@vger.kernel.org
X-Gm-Message-State: AOJu0YxkxECQvx6qdgDe3Zkh1Uo6zVRTCpTzuqLvn3xD2W9yBuLVvmgh
	G36B/CrcYphMuAniFWjd6RMl15D6o5ngrBdIQ/4wXjIXJ2wcAXPNOFthbZGhrnujENs5PBe0YZY
	zOH6evlkG2c0K4rCXwvCqkZq1ivPLFzrX
X-Google-Smtp-Source: AGHT+IGBXZe/BfoQhGCcBUpDtYusZ5oTp7Ld736K+fHn48Fnl9vHhDtZFGbiC6K32A5n5fssAOBdM0goD7CTfYusWGE=
X-Received: by 2002:a05:690c:26c7:b0:6af:9fdc:4bbd with SMTP id
 00721157ae682-6b1b890d1c8mr137102297b3.16.1724151930592; Tue, 20 Aug 2024
 04:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819123237.490603-1-bbhushan2@marvell.com> <20240819172806.6bf3bd63@kernel.org>
In-Reply-To: <20240819172806.6bf3bd63@kernel.org>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Tue, 20 Aug 2024 16:35:19 +0530
Message-ID: <CAAeCc_nV7MYqeMYmjg=E4AJyTBW9QEfoK-4C4Ujcpas6zhJePg@mail.gmail.com>
Subject: Re: [net PATCH v2] octeontx2-af: Fix CPT AF register offset calculation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jerinj@marvell.com, 
	lcherian@marvell.com, ndabilpuram@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 5:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 19 Aug 2024 18:02:37 +0530 Bharat Bhushan wrote:
> > Some CPT AF registers are per LF and others are global.
> > Translation of PF/VF local LF slot number to actual LF slot
> > number is required only for accessing perf LF registers.
> > CPT AF global registers access do not require any LF
> > slot number.
>
> You need to add examples of features which are broken without this fix
> into the commit message.

okay, will update below to commit message

"    Without this fix microcode loading will fail, VFs cannot be created
    and hardware is not usable.
"

Thanks
-Bharat

> --
> pw-bot: cr
>

