Return-Path: <netdev+bounces-163613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177DFA2AF2A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118623AA089
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EE318A6AF;
	Thu,  6 Feb 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkYYRlR6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E454183CB0
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863625; cv=none; b=Jf6B0xPyyFyIRYHO1/pL8Ss0YSqvkvfpLKUBr16Fbf2tqQCmbelzT5hDfU5Rc3duD+v49HBNHCE2/aNluv4nNraswSE3Dxf1vIz/uSQPEu1K0eIxzBapixMVal+e9NXHjAtHRlXQuAmJnM8BRqHzyF1EGX3X6nraET4iwnEmKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863625; c=relaxed/simple;
	bh=gQddVRYw2bj4xya605xF0QBieff6Yng05925km6cxww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfj/HgV/MCpvQyF/H7Kfb2Qc5WaYESUBn1gDkAcYwXmhvWu6+YS/A9XKbhHBCDYLRdk4FosQ4iIo0AdxnCQU5eduYa3vdp8MzECLhkED4oYH53/lGdQUnXWG3cMt5uaUdliDuQzfH6Z+X6Z1a97dsi2JrLdJm9WJpAKbioQl5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkYYRlR6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2164b662090so25524065ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 09:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738863624; x=1739468424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GNqwKcf3Elb0PPe4tBsrtxMgsM46jo1q3LiomU9tSys=;
        b=fkYYRlR6T33+M46abUepsWbKn4HmW9PTE3zsjyVDIQGHcU7lXiyrrj4ZaE2PJSxDnd
         PcO7sKlFfi31AsEKE/W8IFvTi00zMvQ7OqhnPGH9vka5vxSt3rSqlnj5cCfQ4deReMm2
         XioINfjn/mFjzydt3VxpgWPami/5IIajhc4OP7YQqlkj0+HOpmjetrBu5jGg2bfmHlRK
         +QaA8XWi2JwgAvVeS1PaLYxrLU0UIDgGUIbAA435LUYu1BFRp+wK9xnzZOyq5qu01frB
         ae12Kc+ThtYlM1JkwSuzWE6hbIOAMyrvXqws2mBbE1hVyV7/VJjCzg3pRHyHuVWW6Plu
         pvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738863624; x=1739468424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNqwKcf3Elb0PPe4tBsrtxMgsM46jo1q3LiomU9tSys=;
        b=vL4e1dkNxS/vYqtLJoyLakm23GhdeMj8RJ3iOAE7CaZ5EvjlaMGIP8ujw8MQ2w+TjZ
         Z7LLUJiN/UbwTl5VplUbWcRy9xn+C/wMonnibLRLAN/DhY3UEndHGG2JbQpgMqqiiy59
         hpDjx98gjQPniyHhEt/b5gkoU6WhN+723dVRYMqdfefbwNJpuDGmvKSeptREVn/21C7B
         hz+xCXk+FXwIAHwRWmLtA1uGJHKDeGgtPHDiIeL8NVAMumjNn8Dj/XE6gQgjKcDrv8gn
         oaVo8k0r3IjCAXSscTFt8ge2YXdMVYhWxCNzbZ+LzJujzcWUirJcuhlvMQpKZOfQOz5M
         rRtw==
X-Gm-Message-State: AOJu0YyKiPHYnsPxw4gmGLHdAFGmU4KdwSCzRlK/qOvHmc/K7gREsfR4
	Rrv+VZwDsZq+H2Wf4BB3AIoDHPL3K0rPAGpvIrrdjZwCxJbwBjoH
X-Gm-Gg: ASbGncs1IiE9rD8zDt3/cojMf46mLUiFiBWfMtDiOlMoOuGisBTQ+B3XRM2LrlUcsnO
	r0Tx7upcaD8h4YsknOYOIfBR0mvDD7byOnmtLwGGi3g5O6p5EJTnW3aFQoVrxI0zxIE6Nsl8D/q
	O+CoWo31AJaJ0JXKsZPyU6KBORWVGLuNl5o+XXAGn/l12/g1ONAYuXI/0qIRempTGXLOelyyjwk
	Mk4IEKlMNPl+SpGyn9ijDcPifcrLgvn7sVO1YJpfDuAAIMuEtrILCryqrhPDR+poXDDOPXwU6U2
	smwCKhBRnpSuTap+yA==
X-Google-Smtp-Source: AGHT+IErOxG7Nb1gF7PKctkbEZoBCkcJ9UykUaVwkhJla702D59mwDy+StITzX+2bK/6vV+gZMY75w==
X-Received: by 2002:a17:903:22cf:b0:215:a05d:fb05 with SMTP id d9443c01a7336-21f17ebba7emr130680175ad.32.1738863623703;
        Thu, 06 Feb 2025 09:40:23 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:901:e6b7:65:386b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f40f2bb93sm10040065ad.133.2025.02.06.09.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:40:23 -0800 (PST)
Date: Thu, 6 Feb 2025 09:40:20 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	pctammela@mojatatu.com, mincho@theori.io, quanglex97@gmail.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net v3 1/4] pfifo_tail_enqueue: Drop new packet when
 sch->limit == 0
Message-ID: <Z6T0BH9SrlcB5bgt@pop-os.localdomain>
References: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
 <20250204005841.223511-2-xiyou.wangcong@gmail.com>
 <20250204113207.GU234677@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204113207.GU234677@kernel.org>

On Tue, Feb 04, 2025 at 11:32:07AM +0000, Simon Horman wrote:
> Hi Cong,
> 
> Not a proper review, but I believe the hash in mainline for the cited
> commit is 57dbb2d83d100ea.
> 

Oops, my bad. I noticed (probably) Jakub fixed it before applying, I
really appreciate that.

Thanks!

