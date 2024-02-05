Return-Path: <netdev+bounces-69233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D61784A714
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7231C232AF
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 21:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C44F219;
	Mon,  5 Feb 2024 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yur1tmGF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAA560EFE
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162145; cv=none; b=rUDU65dKhanieK9UbCyE4CQ4OqYK7ZTrn/0mdLeoWhuDIT7R3cwkzVDHIQXFJPoc3ay3sVhE0vdCDRGv3llhWsk3b3XuJhgaylA+tuHPwuH0RI0EQ1IdHX8UlXlak4jdRagMrNFhKKZX9ny3EMb/fa9cM73PLJ4KEOrdeFtkJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162145; c=relaxed/simple;
	bh=jHHhwO4XYFOznV01fWKiZQZMx41O0oaVZ/WUu3ZSsOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8WxBGaPLpqsvnWbiwEbxPfEH7njtNq/UVM5kTxkIkx+9k6f0gcUlXR1Gt/piboCAXu3/5uywK0lZy7TPOecJGgX/2++hZ3A5S1aTKoucdWlBhQPoUKnLT2uFZaqHJ057RYV22rWYN+JLK6BM94YKKQGVXLkQi+DBQ3DALTDuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yur1tmGF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707162142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHHhwO4XYFOznV01fWKiZQZMx41O0oaVZ/WUu3ZSsOE=;
	b=Yur1tmGF0vcdTvJHUMZ7YF+/L4KaUFGzY/bXDSf2z2wXtQlufpe/kPgVA7XGBN/ieVjRvN
	kXXhV1DZUC9hhiByLLML8gTQ6TIYjxT/a1utS3bjyxD07hnL0IA7ieAPtj4a6JZcC6/utO
	YJ0uv10Hy9V9Au1cnZmPFrzro6RyODY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-LXZiPFfpN5WOcS4oBkWJGA-1; Mon, 05 Feb 2024 14:42:21 -0500
X-MC-Unique: LXZiPFfpN5WOcS4oBkWJGA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55fabc6adefso5217935a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 11:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707162140; x=1707766940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHHhwO4XYFOznV01fWKiZQZMx41O0oaVZ/WUu3ZSsOE=;
        b=aqZZ2rDjPlIpBgnrLmiYI1rsuR4LNDOMIuYrVBFEk9maufIoutPAHb/VqwPR/gEMv/
         dfedPMQSTO8FIZjL5cKVUbfEqXehskE/+6p//7GOHUu/v7E6JqFekAjydQgOdf/KX+oC
         04w+jslA+UCk6quVkixQ8GvHIfMdUBJdCr2cskUtE3tf9i/GUqISPLr5l21kuSduEVB0
         poSvRFRveQ+KuYnVMTOsulCIVlHRdFavdD+M8DUmniLTPzePUPL3b7H/r7sADMSX0ii/
         NQ2RMX1TB40Um8U7lhIGtYJOybfigWJHRKABHSRVIqv1kR5TAVw+WQEUZcRuozctvxu6
         CpSA==
X-Gm-Message-State: AOJu0YwKN+0p681S7I4+T55W7GI1XNvgk+0oEacOX6JrPYHsjD/CzASx
	zP22+QLFdmrXi/Balbnq0R/9CvrqChVn6pzKHgzPkUPkzq3fQJr0xIC0W4ZkEchPcrILw6axTau
	XJwjHu1ncXsafQU0UDczaUKBnv5uFeZWb5W57lSBFkQsWEL2wKdAi0NNgqqYxlsi20v3gVEuzP9
	SFES5bAao+tOkiW5NRrDnnSk1csXvC
X-Received: by 2002:aa7:d893:0:b0:55f:e543:b006 with SMTP id u19-20020aa7d893000000b0055fe543b006mr689419edq.13.1707162140572;
        Mon, 05 Feb 2024 11:42:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrKHN+f7FGpriqh0DUpVTEJoFk6gp1bibeEGrhZ3Z0mW7IbHPTLkTvDCIiZ5rH1Tk1sf5oIM7QHRmM+sb3QmA=
X-Received: by 2002:aa7:d893:0:b0:55f:e543:b006 with SMTP id
 u19-20020aa7d893000000b0055fe543b006mr689407edq.13.1707162140360; Mon, 05 Feb
 2024 11:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202064512.39259-1-liubo03@inspur.com> <20240202085547.46c81c96@xps-13>
In-Reply-To: <20240202085547.46c81c96@xps-13>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 5 Feb 2024 14:42:09 -0500
Message-ID: <CAK-6q+jnZOkSAM8_BQH=CaQhfCQwm0P+segZ+0E6oLeX=BhLHQ@mail.gmail.com>
Subject: Re: [PATCH] net: ieee802154: at86rf230: convert to use maple tree
 register cache
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Bo Liu <liubo03@inspur.com>, alex.aring@gmail.com, stefan@datenfreihafen.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 2, 2024 at 2:56=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Hi Bo,
>
> liubo03@inspur.com wrote on Fri, 2 Feb 2024 01:45:12 -0500:
>
> > The maple tree register cache is based on a much more modern data struc=
ture
> > than the rbtree cache and makes optimisation choices which are probably
> > more appropriate for modern systems than those made by the rbtree cache=
.
>
> What are the real intended benefits? Shall we expect any drawbacks?
>

I doubt it has really any benefits, only the slowpath is using regmap
to set some registers. Maybe if you change phy setting frequently it
might have an impact, but this isn't even a path considered to run
fast.

- Alex


