Return-Path: <netdev+bounces-118413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E6E951844
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 12:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AA3280238
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4F1442E3;
	Wed, 14 Aug 2024 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKvarVF7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934418E3F
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629837; cv=none; b=spd7e4vD3eZTRXpce3Z0AiSsJBihdErqpcjGRAekXKK6yJ6EZEQ7B9C0PUSAZJ6MqccnqPVNyKEd2LKSZ11C6365CHNFZKvBi6sJsP4leManuihr6eu1rMug2e/zTlrr1xR/aiXh7/vYI9rdSoEk7SLtczNc/CG0roHaMT3DsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629837; c=relaxed/simple;
	bh=HHAmvxbqr3oTWqcVg2VftEf3MWoU1Ghru/F8yLOVvDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H7ALzdQego+kXDxiX0ZB7smIbR+Dga6fX6oA8991ApiNlvfdsayrJ/G4J7VS6cRdc4cKj3UbDcbkpABSaCYvkJ109cbblgL9FTkmaIgWjHpapKqerHgpF4yAymZI0hyWfuN+7rjrSHz0mci/YiIUP1bpa7LaiNr/UTTbm8EXI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKvarVF7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723629835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHAmvxbqr3oTWqcVg2VftEf3MWoU1Ghru/F8yLOVvDQ=;
	b=iKvarVF7M9pSR/G37y0QEBIM8IwCE/ILzNFY3H1I728/3Mk6KlHqnTb4x2XsOky/7FiKww
	aYEwqZ9+pQW+Me75sj+jlCPrRoEBc9xdKretCT+YJQinEGFOQkCtkZlGwN4ZiZ6CmI7DrJ
	GC6KobDXCYChMQ4Z2IE3TSwVSRJiv4w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-JFVV3xtQM4eX_SxyHxIg7w-1; Wed, 14 Aug 2024 06:03:53 -0400
X-MC-Unique: JFVV3xtQM4eX_SxyHxIg7w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3686d709f6dso3606007f8f.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 03:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723629832; x=1724234632;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHAmvxbqr3oTWqcVg2VftEf3MWoU1Ghru/F8yLOVvDQ=;
        b=BwJ+ZWNXU10YCa3GK7x23LoQMF0/Vwj/q/yDghhxvh19F9hX202jjDydu4+MEOpehz
         f+QHK5d28YlCv2jfTRcSJm6n+sqa0UWZ9HEhJ9OBnFYsNPeg03Vli5px9WUpyYcNlDpL
         jTklM02FuP5YL43qD3ibXbf7y8Gm77f/yggQP8orlNlSCHKlbCgsghd8McCdKrVZ+lPd
         ONfTmDiAh7sRALdbe5g53lcfdI5yZdl7CL02G/zu2Y3yNrEbV7RSCpUoQZqjxcVBk3Xm
         ghlwwqzNxS4jKY12NzX7sdqUEkbebs2yucr9r5dFfGgsdpxE/iqcC/dyS3jq/3g4fO2S
         gDyw==
X-Gm-Message-State: AOJu0YwEqQv/48F1+O+1AP3m4a98WD7L4PkmdEAAldnDDl0Chsj3bwLG
	1YT1pet/esvsfrTdOLW03f/ivHrNfzNrStyEPxBCJZ+gNXn7wAt6zcmaje3KNRY4u843hAjKAlV
	OJChNvczToZJlAB08zQon3tt/pRV2F/Q3UNYRW8fHO74k3/YSCpn3FQ==
X-Received: by 2002:a05:6000:1049:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-371777f581fmr1398810f8f.46.1723629832607;
        Wed, 14 Aug 2024 03:03:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxP0Dm5DVS9b2ZUnhPaMUqKbIjlq6FmWZPRNS6MS6q9AXInO9Tsh8UJIMQ+uCsd1sLCLDm4w==
X-Received: by 2002:a05:6000:1049:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-371777f581fmr1398778f8f.46.1723629832015;
        Wed, 14 Aug 2024 03:03:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36ba51sm12582758f8f.11.2024.08.14.03.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:03:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0734C14ADF74; Wed, 14 Aug 2024 12:03:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Feng zhou <zhoufeng.zf@bytedance.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com, zhoufeng.zf@bytedance.com
Subject: Re: [PATCH] net: Don't allow to attach xdp if bond slave device's
 upper already has a program
In-Reply-To: <20240814090811.35343-1-zhoufeng.zf@bytedance.com>
References: <20240814090811.35343-1-zhoufeng.zf@bytedance.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Aug 2024 12:03:49 +0200
Message-ID: <87y14zctfe.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Feng zhou <zhoufeng.zf@bytedance.com> writes:

> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>
> Cannot attach when an upper device already has a program, This
> restriction is only for bond's slave devices, and should not be
> accidentally injured for devices like eth0 and vxlan0.
>
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


