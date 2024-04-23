Return-Path: <netdev+bounces-90554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1268AE791
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC88828729B
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B41D136676;
	Tue, 23 Apr 2024 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="A+JgPx5+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D7134723
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877748; cv=none; b=NsJKybAZiZ81taBOuw1Gj4mx1RDnR5fj4xtqyMXYtVTxSSQP0nPQLe26xQk5ydzOP9S+B7X2nrccvyKo/L0dr7wjqtJu0BJ7xMujm8FIESAhp33GT1j/UMGiM6RYhkc7D+SBUfcnoy6eg79G1SNoPEERHrEhgUxfChaLSVh+QK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877748; c=relaxed/simple;
	bh=gNo0LmWOPqhVNl+jxyixW/6LiY/Ep/Jo0UKGJTcDgQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVfKK8Lq2KDTXg3VSaVc+8X8yukNUotWMHtQbOm7pHohMqaff8PGc3qhroI+rVNZYqYEnJ/RJXt5WVdgAeR+zFlDQu8MsdL2ADYUn2qceuiVrABgyxl4RSBwK15Fw61QlDsG8IgOCJLDGKvLdyEBu8dn+EjQ4CGReFwH42GjirA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=A+JgPx5+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a56d7d457a1so216041566b.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713877745; x=1714482545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNo0LmWOPqhVNl+jxyixW/6LiY/Ep/Jo0UKGJTcDgQ8=;
        b=A+JgPx5+gyTD2VqSgk8ViAqsshU8AlkVMZC7I5kazpSN766d5fuTboZPIqDBRT4Kxd
         5KAhPrtKdX/DqU/RTmZ3dBZY9qT4hMTpta5qun2ve5xsfS4Q9aSC0AOBXQ+nEybNyfbT
         djF8n+ExG7TqeKe5gxoHILUYQkk/6ninTY+dCh6951HOR2z5oeocRX/XBWeoFzTuwXfm
         g1NPjt/aa0uCTwv7qZmehROnSq5CmpLgUN4ZMuhBtbtyPVAFMTAy74rtb0rJGdFrruEl
         KEuNU9mwW7q/LbJH9YF6PTIWW36kdHPowdbcyAc3U+RhvxzFXgztcX+k1GDk1k+f3loJ
         JHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877745; x=1714482545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNo0LmWOPqhVNl+jxyixW/6LiY/Ep/Jo0UKGJTcDgQ8=;
        b=Y2WF/gNIRqxz7czok9RQi5Z/h1ynfS3HtGcPc3Y15UnqccFHxpZp1i/NDZPIVUjpQi
         Pw/ShCVzRWW4WjH9Ybn9vM8NGEqv7MOTx9QkqV+kfPFBK4nZ6b9HzYLjbz1k7ZZKth7d
         gyPItdyBsaHW2BxspKNIYb2XQ+A0OC3wFiit3qQKgGcy7T4lREMYYTLWhkSG3CDI0nn1
         NayX93zjgBZbPLAdSgrKVcOxQRvz7OVj040dgjx+jMbvYjahI5xcujNOq+CB2WimBq58
         ImyxVgU2+rX0zYcduelaKw+I6uE1RwXBquhfBNELsbdPr7cYIgKlbPAr0pYIoNXYLGN0
         KS8Q==
X-Gm-Message-State: AOJu0Yx/ep9yq4a91bKuaZ5pMQh5PI8pOxR/3OFBi1KnLqV94GSKkIM+
	/FjG+RlAPg8ty/PEfp/U5Kr1ud1SQ+BpwKckKIs6aQo6leu6Oduog2rZwWEjjEU=
X-Google-Smtp-Source: AGHT+IGGV3cMx7n73xu9piqgS5B78n0mromdcQW+kQPmLzLjaLc2OR5W9GFUJLs8cBihpYxxwNmLOw==
X-Received: by 2002:a17:907:7242:b0:a55:b2bf:2be8 with SMTP id ds2-20020a170907724200b00a55b2bf2be8mr5638170ejc.56.1713877744498;
        Tue, 23 Apr 2024 06:09:04 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id qu20-20020a170907111400b00a5242ec4573sm7004707ejb.29.2024.04.23.06.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:09:03 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:09:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v2 5/9] octeontx2-af: Add packet path between
 representor and VF
Message-ID: <Ziey7sruZrtq_5Hj@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-6-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422095401.14245-6-gakula@marvell.com>

Mon, Apr 22, 2024 at 11:53:57AM CEST, gakula@marvell.com wrote:
>This patch installs tcam rules to stree traffic representors
>and VF when swicthdev mode is set. To support this a HW loopback
>channel is reserved. Through this channel packet are routed
>between representor and VFs. "ESW_CFG" mbox is defined to
>notify AF for installing rules.

This sounds very wrong. In switchdev mode, there is no implicit packet
forwarding. User configures that, either by setting up TC filters to
match/forward packets, putting representors in a bridge, etc.
Basically the driver offloads whatever configuration on representors the
user does, in case it supports it.

Please make sure you follow that.

