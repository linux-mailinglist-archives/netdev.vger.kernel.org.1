Return-Path: <netdev+bounces-76094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2751486C4CD
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6979288422
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC7359170;
	Thu, 29 Feb 2024 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qvyVbti5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A615916A
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198410; cv=none; b=SnVor/i8WFOrFgsS5+hKaC/RvVxeJT97tK7iCbX4YQzNfgbmFaq4HZM8eEV199rrPEkzUT+fLwL9Ynm0Q07xM58l0SvKgXIsqvsAxKJd1cEb2G6Sa6w4F1iUFqKd0W2OX/zI1uLajiUdhfVyq+5bFa9FYw7paJMr/cKoY95wI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198410; c=relaxed/simple;
	bh=9ld9CHJWAVfxgUOV9rgblXkoVNbUU8Ep4EODEe+gquw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnSeslt0uCwozqsMZivpl1ZqrbDjuY1+WHqkLoLBcKbrtSj2Wz0dfOM+d7Ogy64Zb1Xov95NZZNZ3xjDsCEiZi7VVONvoDXH3EwXF9nRc1Kaz62v79doOAoi6T/SJOuMKS0R+hs8lDIAilRDdSldF5ppaLV3wyLErdUnq5bLKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qvyVbti5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e72ec566aso106619966b.2
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 01:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709198407; x=1709803207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WwQvPtrchQr55jMR6QmPbP1tMQ2V4TzDErrhsqCBXY=;
        b=qvyVbti5bozXCdsuTMBIZEahD6J3GQRWEwaJu5AKhnvPrTe7KNM45nkphjeUb0GgtE
         M46iKWGBW/Hfj7Eir6pyMJcfMMj21cj8l4XnbVb9xdqDqVapHWoa8oXMTR+qf40JCmKm
         VPlnl9o97X/bTt8+rVMbA3iFJoYkB2xEk6kSY4lXolqzUUYppfupnwUw5WGfcheRbf+n
         Uky4Q97DAvJD7aznUwNIr/Ju2rSpm1sMGighC8U6BopUvBEy2HO0838R0fOfh88X95s/
         AF9etQiJdvEdbdylDsNgKs3LdnbfPPyCUjnFsNFnaQ2jLD7CVLtBgjAtGczoF4WZj35H
         05aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198407; x=1709803207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WwQvPtrchQr55jMR6QmPbP1tMQ2V4TzDErrhsqCBXY=;
        b=mrK5zmy/2RYlPPANYy+VG/jznWx5p8WeSc039sM0XmV63wYKhr2MJNBKFt4KIB36H1
         mtjqGXKlgpst8BJKVWtugsAdfT9AFBESiLSLy+tGIEeu0m2ZFssI4JveKNW7+SV8dhRs
         t4bv9r0L1g77qk6VN4UUUVDx3GwU9GPZtVlYsH3+zUuplFo5m6ISVmF3DY4WRvbgscIJ
         KSmS15EChYlX5uznGaX0CXnOKvGZZlck4zCMoHGfPq3oPELilOYrTVkmlgUkVnvQ8TMi
         TCWW9lpUNyE/iF0wTNf4XUC3LWZkfmgZh42LQBWFFNPiIsxWwtx/bniLmJF+fcvlgvgl
         nsyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVueB2x7DcPFSShyM3VQ4LvNKgRbnJTW/W8n3Co5Cq1XVf3ea9lH6jGbfh7p+75tXOXSsX9+PcC086KK71UIpmn8zIyzDDg
X-Gm-Message-State: AOJu0YwxbxuFwj9tETO+Xn5AsuNLqu/A8GPdL6FtzHPCKq4jx1/2kRjc
	d3fk7LiZLYs6O2ezLRi6UxL7huGn0TcVAONXDhbPR/X8PtS+7i9ZlpO9GJtXn9Jqi9DCIIANiXj
	YqnQ=
X-Google-Smtp-Source: AGHT+IH4DjWRcIUwOnrisXOgXOTPoAtgvr+Hfo1U5qDrkqpiXjsIbxHBau+xcepAx4WAx5xlZ3c19Q==
X-Received: by 2002:a17:906:1c4b:b0:a3e:a3c3:9658 with SMTP id l11-20020a1709061c4b00b00a3ea3c39658mr1054883ejg.22.1709198407361;
        Thu, 29 Feb 2024 01:20:07 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090699d600b00a3f4bb02bc8sm488281ejn.42.2024.02.29.01.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:20:06 -0800 (PST)
Date: Thu, 29 Feb 2024 10:20:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>,
	Jakub Buchocki <jakubx.buchocki@intel.com>,
	Pawel Kaminski <pawel.kaminski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net 0/5] ice: LLDP support for VFs
Message-ID: <ZeBMRXUjVSwUHxU-@nanopsycho>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
 <20240228084745.2c0fef0e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228084745.2c0fef0e@kernel.org>

Wed, Feb 28, 2024 at 05:47:45PM CET, kuba@kernel.org wrote:
>On Wed, 28 Feb 2024 16:59:44 +0100 Larysa Zaremba wrote:
>> Allow to:
>> * receive LLDP packets on a VF
>> * transmit LLDP from a VF
>> 
>> Only a single VF per port can transmit LLDP packets,
>> all trusted VFs can transmit LLDP packets.
>> 
>> For both functionalities to work, private flag
>> fw-lldp-agent must be off.
>> 
>> I am aware that implemented way of configuration (through sysfs) can be
>> potentially controversial and would like some feedback from outside.
>
>Why is the device not in switchdev mode? You can put your lldp-agent
>priv flag on repr netdevs.
>

But isn't it a matter of eswitch configuration? I mean, the user should
be free to configure filtering/forwarding of any packet, including LLDP
ones.

