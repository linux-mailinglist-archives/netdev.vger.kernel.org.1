Return-Path: <netdev+bounces-184580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC3DA963FD
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A743A3162
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F631EB1A7;
	Tue, 22 Apr 2025 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fPmyyQpn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830E1F151E
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313509; cv=none; b=ZmuM8k6zu/gL8DVj1u+/ANwPKJo69bTpitE4Bd573qZ6go/ea8gBg6ji2dAGOrlP2szevSwN0+CNS31WjyWCZPFIQST/Jbf0mHvja86RZ6Wqxpmz3jIqlfXJYhy2B8Dk42AZOhQ7F/h87peVDHcFmg0FGyVn/5W9GwgAfosEdTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313509; c=relaxed/simple;
	bh=d7eIeT9FZFY89i5wfhwpFdeC7VPIv1U6wLdokmNZ/6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufkOuawDxBh3R5TnelN/8/WzeAbt8Dx3WRK1pBwbcCPB8JFCdMviTTUkWkpa9zkRFV+Uk3rKF6O5V3sMWVlREHTKPNsvCxdGar+/VaFXK31wh5fIUSvsBU+w9yJUtNn+6mqy90upxE/fTR0tXN3Zpgk7sJWUYJ7AWmor1EH4TM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fPmyyQpn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so51293395e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745313506; x=1745918306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+RdjoJlg0hi28zGgBtHCFNDTL+4+uZWkJ4jKZNHMsrc=;
        b=fPmyyQpnGrtxvdKbaRbo1yCvd60l59cngN8fucsl6kQA6A16yTgMLAd7lRK1koVGyb
         1UWy8KIwubr/TcYhrZjAEAw7QdESk9msHV2izJ231M+91uZlZps0Czs8B5JS7wD6t7tQ
         oWL+VCxLBezVYSYqE8AsVS3Hi/IeC1yeCSpe6qrJnBrnWVxx7M1m5/XYeNkg1iIWkwlt
         abHlW1xkhg1bgjUL1DasuU5rfVksxA306ruHh1fBfe3KPOCytKDId2eAYia+VYX1M6Kk
         hyUVStIdOA7uzv9NFx3adsndGznFjW11tTmU0OZI0fSquEpwAcXfnmJ1H6SMqsN94zly
         EtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745313506; x=1745918306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RdjoJlg0hi28zGgBtHCFNDTL+4+uZWkJ4jKZNHMsrc=;
        b=U5U1TDt6tAd9oOxqp54dFbIcf0XPJbEXx9TECW83/C571IcfGaWSybBqu221RkII5H
         9j45u+HBLWl4E+A6EBlU5YJ6JCTs+2OjR1WP9GRkEoB8zW6AqGrljJ8pFu7cMo7R+W6H
         AgFCDn5sr5bNixaxhc2avdANP5eZZxEs/eWZsfuYpZ6HqhGc2sP+25S4sEHktWYb6rdM
         AvGDLPQc66MV9sZer0BU8nKqKUOImws321nHdIrMzTZNfGb+HHIf+HpIanhZCc2DDrzl
         JkYlt0r4PZ9agw0p8Y1mDCJAlyTrElA0dP2ptI72PRZtw/jRp679gv6KmxA4nmicsrtZ
         yhmQ==
X-Gm-Message-State: AOJu0YwMjaio4QlWsKuByyxHt26zCl5Xmd0e7QVvqFQP0uCTjTT92P51
	WeotGjpY1Y9a9WSgF4bnPabFA4GD6GdOJcUTw9HI/f6Znl2m2PmQ5L0ruf3PpG4=
X-Gm-Gg: ASbGncsnd3r8AuuvsDJIGQvpqOvQngO5NoiPLGOsMUjcryt41d7AakFGLyQDvGSmLL8
	rb7VqxbEnuWTGXsFNcOeG313Zu67djnQ6t+hrW2rw6piFqIMoobai64BFe/ZH5PmIi7mLntxAii
	cwLmh35VAVQsepByxZfwvVKbcRTBESM+uSKKNTqCo5hJUU8oltzbCd7yhNhTrE1a+Wj7QkX1nDF
	ftIcmJmKDz+++ibREE8tdaMViE2jxLrqytTTYzO+rJAKYporhu6yTIKgiC/QF6R8PbS2gq1CHog
	NcWvqT2fhGlyo4ApM2dCvoYOFerb4fvAzvzcEvsCtNyXV9UGTQaxfHqT+ZS67ABp7Jzs
X-Google-Smtp-Source: AGHT+IFML7PZZprDrgsxIn1ZQe5x9hLLSR82MPLU/biw4v7TUsY7L+BwUA9Z+27H4yWxLIxej4k86A==
X-Received: by 2002:a05:600c:548e:b0:440:6a5f:c31f with SMTP id 5b1f17b1804b1-4406ab93420mr127229375e9.11.1745313506271;
        Tue, 22 Apr 2025 02:18:26 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4207afsm14723062f8f.12.2025.04.22.02.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:18:25 -0700 (PDT)
Date: Tue, 22 Apr 2025 11:18:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, tariqt@nvidia.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <5abwoi3oh3jy7y65kybk42stfeu3a7bx4smx4bc5iueivusflj@qkttnjzlqzbl>
References: <20250416214133.10582-1-jiri@resnulli.us>
 <20250416214133.10582-3-jiri@resnulli.us>
 <20250417183822.4c72fc8e@kernel.org>
 <o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
 <20250418172015.7176c3c0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418172015.7176c3c0@kernel.org>

Sat, Apr 19, 2025 at 02:20:15AM +0200, kuba@kernel.org wrote:
>On Fri, 18 Apr 2025 12:15:01 +0200 Jiri Pirko wrote:
>> Ports does not look suitable to me. In case of a function with multiple
>> physical ports, would the same id be listed for multiple ports? What
>> about representors?
>
>You're stuck in nVidia thinking. PF port != Ethernet port.
>I said PF port.

PF port representor represents the eswitch side of the link to the
actual PF. The PF may or may not be on the same host.

Ethernet port is physical port.

Why this is nVidia thinking? How others understand it?


>
>> This is a function propertly, therefore it makes sense to me to put it
>> on devlink instance as devlink instance represents the function.
>> 
>> Another patchset that is most probably follow-up on this by one of my
>> colleagues will introduce fuid propertly on "devlink port function".
>> By that and the info exposed by this patch, you would be able to identify
>> which representor relates to which function cross-hosts. I think that
>> your question is actually aiming at this, isn't it?
>
>Maybe it's time to pay off some technical debt instead of solving all
>problems with yet another layer of new attributes :(

What do you mean by this? We need a way to identify port representor
(PF/VF/SF, does not matter which) and the other side of the wire that
may be on a different host. How else do you imagine to do the
identification of these 2 sides?

