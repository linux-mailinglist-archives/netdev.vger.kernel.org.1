Return-Path: <netdev+bounces-242379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D021EC8FEBA
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 19:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC61F4E129C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232592E7F21;
	Thu, 27 Nov 2025 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIGnIJVB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5224886A
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764268060; cv=none; b=bgiwFQnI45ln5neBDqV7MtvrSq6K5Pv19Jv+7yE7mwEAHyAt3sPbjA7pzcEJ3IAt9axFHcGF8CB8oVDFvWnkMr/W6XIx7Z51jVzwert3eJQQ4/ajO05FOXsfWLlmpL/9q7pihThfaq1lfeIVdWI/EhRIycXS6GCNkKqQAKfqL/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764268060; c=relaxed/simple;
	bh=TbMYQP1gcM8EPYojsQiCVI9Gg3t3fQA7PfmVvMn9pxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/KUnvg9KV3N9rt9OjzDM8daYuEn6XCTpGuH484jSxplXtmSzclJTSUKrG71/g1Txr4qoVmLm5+uhFRi8pYl09cj5mKuqABmNrO52dXWt/rUEFFbexg4qVjUpLwoXymzsBaC0cBNr8KBCsm+5FWpqImj89Ri+wzAHoPD9tkSJrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIGnIJVB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-343ea89896eso1062579a91.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 10:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764268058; x=1764872858; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0CMVGAuO5wqFF/9s4vk28iQRbRU4P2KKj9YXBpRmdYM=;
        b=HIGnIJVBuDDce5hGe2+DdxmK+8SfdghP0MdnCEjx44eQYJVwsTgvX37RX3OfZ/GjhB
         XcWEt95rtOJQ4vubuCG+1eNLe7NN2WtRUIUn8mKRELCc2aIa6G+sZOVfjhdNrMvW071w
         9bhelxFU8PAagoKsT7YDqFsHoEFD8KtJgcEEtVt8AiXpSeaS57TcIpZhiBfh7vqW9z5r
         8O7XpbLpq0K4ehA7o4geSntCoUgHwNrcRIuLAUowL3DfwkDUERWZp8pCx3jJxuNcz54D
         OPFml1QWro1uvOoUH/ErRYNW5Q1nYCWcw7f5LuLaFwxKkc6RUY/rYSMg8ZiD6uw5myTP
         9jFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764268058; x=1764872858;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CMVGAuO5wqFF/9s4vk28iQRbRU4P2KKj9YXBpRmdYM=;
        b=r9fBCOZc1k4PseK7LkSUhe+LvtXe/9u2hcK9nbvh5xljeDZPT/kiUFJlg1uMzMrLZo
         5FJGawjqxcQ6jvloVVxOig+iiOd4/Slpz4jo0trq809O0i9ZrGZ8m5aMLCniSfL8OMtW
         tmLbQaxZp2Bk64RY+yUZB9ZU2AOSEe7T9AQDN5yOnfoJZNVRjiOr6YPIIZ0388o44waK
         uQDhN+6NVGcju+7gMBhBRtgN2HmoPZ85v6a91BUcbAfO9JYfw2JoipWDhIczFgBIz87+
         2RpOrdDpledmKBXRBSmdRxu1IZ3zFQ6n0xwbuLRlGrr+xKFpqskqwgklaK476oWudCf0
         PMng==
X-Forwarded-Encrypted: i=1; AJvYcCX4JDU/KtJSoXhhgNeZ1sZ8N1yNcijjIlkX6E9FUJpi9C/fdBRNjvcfR3Yqvzv2c5PDG5R0jlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywie1XzFuTggNgUJbxxr3FXS3l+OwolO7VTXxTEh0/bSGFLf3F2
	5dbCiAT5yH3zoXxNfI6NY4MZ63Qq54n34+5nrwkIz85VzkKeuLJ5S4yT
X-Gm-Gg: ASbGncs3PdAWghFxm/qXZbSWFQlKpY9ien1YCvkdWHgoJdmPTZMWxPNgwoATdAPIjXT
	3ohl25zeLMyBNk1/psjZhcww6QVnIwnpP/4CTOO+84PjchhVFvXchQ0Ql+MVeSpecppT2CqUexk
	siOG7Ev6XT/GNDLH+MpViF29m9NWlqtci11A5OkQ5oXM4V6oywsPuaCUICnRMNwvI4vAm4u8MVn
	26zc+l5hotEAu8QlWR0gkG7Hb6klrXd2YhSoSAMIuh9cJyFNmjkiYzKR9T8CzAuBmjipKDu9/pr
	4Z7/CP3dB972MPM+oNg1A0FhunH4G5J4lZT8pSPb4YB0xdHd2+fUEM4TtURS0sXO/WmGQzbfwl5
	0/kfrQ5nXmpIosw9MggogcKErhRhPee2IFkWgWpVWmITGaZC2LfFLA8OgKr/TqCwcaoOiN4FZzf
	KkGU+KDPknkvns4xeEhIY8QbEKh14P
X-Google-Smtp-Source: AGHT+IGmOQn/7Iyw3cNCmmtlFpPj1vTc9hwuBd70jhjhxMIyoDPclV8Z/6/KIWSshi3AFbKHPxCWDQ==
X-Received: by 2002:a17:90b:2d87:b0:340:9d52:44c1 with SMTP id 98e67ed59e1d1-34733f3f6eamr25933547a91.35.1764268057716;
        Thu, 27 Nov 2025 10:27:37 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:ef22:445e:1e79:6b9a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b20b711sm2467395a91.7.2025.11.27.10.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 10:27:37 -0800 (PST)
Date: Thu, 27 Nov 2025 10:27:36 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonas =?iso-8859-1?Q?K=F6ppeler?= <j.koeppeler@tu-berlin.de>,
	cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Multi-queue aware sch_cake
Message-ID: <aSiYGOyPk+KeXAhn@pop-os.localdomain>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>

Hi Toke,

On Thu, Nov 27, 2025 at 10:30:50AM +0100, Toke Høiland-Jørgensen wrote:
>  Documentation/netlink/specs/tc.yaml |   3 +
>  include/uapi/linux/pkt_sched.h      |   1 +
>  net/sched/sch_cake.c                | 623 ++++++++++++++++++++++++++++--------
>  3 files changed, 502 insertions(+), 125 deletions(-)

Is there any chance you could provide selftests for this new qdisc
together with this patchset?

I guess iproute2 is the main blocker?

Regards,
Cong Wang

