Return-Path: <netdev+bounces-90961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989508B0CD9
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552E528B36A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA215ECD7;
	Wed, 24 Apr 2024 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XBv9tqD0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0694615ECD3
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969708; cv=none; b=Bf2I0wW+LApWXwOhNSv1lsxvnEl10a3ISETpDEuoDMoDFiLHJbZTY2sW49Vdik9UXPR8fz8aAItfiO6wETdTv63cgwj/t+NLU46+fugWsB50sWSOvC+BGEDXDJ9T1jdDV9NGJC2djvYUF4uMTfPXw/cupodqNnV8hqxNLPlGw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969708; c=relaxed/simple;
	bh=jzg4BBCh3cq6Sy73nNHz9QmiKL7thUrN27kWtWd508g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7ZltitiKsHj0zrNsq5qDuNQX7i40YO1yzwrkAHZJ5+MtBrGEfqjWpUAMvG2HcKysXKE614+I5IkUjbgPwNKzUokClpA2no5LqdUVwJi4bxvnTx4uDuITFjYa1RAREflHqeeeAsgwn3p+frh3OJ5CQcs7FGES+93wqoLOLIcYXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XBv9tqD0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41af6701806so7663365e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713969705; x=1714574505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=585fL2S+MdCX45+yRKa17/Q5RuA1bShcRMqVY48gZdU=;
        b=XBv9tqD0fBNUeaI1WBbQOxAVEBf4S4HGNviT8nn1140EdxlqfAUWvGFjr+3Br1UJze
         /XizQYDYC9lX53nXtyv4tPRExKXGjBY3Ewz+ygDLSyCgLacMk3WLjtpjCzz/4LrmEQ1/
         2kL/eK0vjCl3agz1aRXWjIrqRrtp4poii8bFhxLXVfvoF2uSOzZ8Mnnv5dNDzhsCjSp+
         CEYE11Md1hYxFzex3frfH8bTNkgIXysM6kPyWgVgQqCApfk7xJtJ6E8gjstG53EIE9Lh
         Q3HUCd2fmmrgAr7S/v5CbsVvekvxA/vDoGmId5f5kGnp/n1snOfF+VmP0hrpvy6Ef8rj
         17ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969705; x=1714574505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=585fL2S+MdCX45+yRKa17/Q5RuA1bShcRMqVY48gZdU=;
        b=soHDE3lBpEPwL0fH+tsJlfuFI1S2KeUmg4Hej1RP2M7Jh7qBwvL6xCt7Rq95eKZoUO
         /usDqs9R5FkmHXe25ei9+FznYD+LgZuEN3XfA/FAMcsFatlNzL5dbXmPxs1Pxtk/pXdF
         gzEkfZr1h4w3DaPY/2K2AFpkfAcKlYMpk2eSwVTqJIrLr+5P9jTgaR1Zr1mw7nnVHmn9
         w+ZPG5S02wQPtp62fA2NTJ87x2w5GB6b2L5nkKlihQMJBHki8xX5y2rsv8mGOwWLQhT1
         05gMpXdtoFFW5/q3SVtwbYyUSRhpMk1GPRV2RkYeDQqhdAs2/ufc9wlu2YaJl40BA9kq
         IauA==
X-Gm-Message-State: AOJu0YyOcZkho69PXk6t/VJLV3K5uY5BkZkztjIbm1seQ5DWnN76U3MA
	5Rlm5jLgZqQbuaeK8LxWTzoFsp1QJdKxUstSJWOOoGRExrgEdgVzp7uVy4ELouU=
X-Google-Smtp-Source: AGHT+IHWqJp4tQPcJyHxmVz/5N3oHbhRsRwdcDsdPdmvKxnidXnLBunMCjixUfJ6D/xIoLjodQUuOw==
X-Received: by 2002:a05:600c:1d99:b0:41b:2e2f:5828 with SMTP id p25-20020a05600c1d9900b0041b2e2f5828mr34312wms.29.1713969705262;
        Wed, 24 Apr 2024 07:41:45 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b00418d434ae4esm24078115wmq.10.2024.04.24.07.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:41:44 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:41:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v2 7/9] octeontx2-pf: Add support
 to sync link state between representor and VFs
Message-ID: <ZikaJcqEqwhN-RSE@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-8-gakula@marvell.com>
 <ZieyWKC7ReztKRWF@nanopsycho>
 <BL1PR18MB43427F05CB1F5D153DD54907CD112@BL1PR18MB4342.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR18MB43427F05CB1F5D153DD54907CD112@BL1PR18MB4342.namprd18.prod.outlook.com>

Tue, Apr 23, 2024 at 06:09:02PM CEST, gakula@marvell.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Tuesday, April 23, 2024 6:37 PM
>> To: Geethasowjanya Akula <gakula@marvell.com>
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>> Subject: [EXTERNAL] Re: [net-next PATCH v2 7/9] octeontx2-pf: Add support to
>> sync link state between representor and VFs
>> 
>> Prioritize security for external emails: Confirm sender and content safety
>> before clicking links or opening attachments
>> 
>> ----------------------------------------------------------------------
>> Mon, Apr 22, 2024 at 11:53:59AM CEST, gakula@marvell.com wrote:
>> >Implements mbox function to sync the link state between VFs and its
>> >representors. Same mbox is use to notify other updates like mtu etc.
>> >
>> >This patch enables
>> >- Reflecting the link state of representor based on the VF state and
>> >link state of VF based on representor.
>> 
>> Could you please elaborate a bit more how exactly this behaves? Examples
>> would help.
>> 
>We patch implement the below requirement mentioned the representors documentation.
>Eg: ip link set r0p1 up/down  will disable carrier on/off of the corresponding representee(eth0) interface.
>
>
>"
>The representee's link state is controlled through the representor. Setting the representor administratively UP or DOWN should cause carrier ON or OFF at the representee.

Put these into patch description please.

>"
>
>> 
>> >- On VF interface up/down a notification is sent via mbox to
>> >representor
>> >  to update the link state.
>> >- On representor interafce up/down will cause the link state update of VF.
>> >

