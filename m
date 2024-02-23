Return-Path: <netdev+bounces-74278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5D860B3D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 08:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8100D285FC7
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 07:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8C712E6C;
	Fri, 23 Feb 2024 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Vo0aHmpZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318012E43
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708672624; cv=none; b=QsEYVI2CAxo+5AWI52BVT3ug2YTo43I+AtHqM1YsyO5Bklwhz6qwNe/2E1Vdo0FGHEKJvIZqxMeAmdCTh/2f1MbjaSob0ryGSpPk+AOsGrT2Bu83xldhrpOMFHfQ2LAq691/HIH/SU34J2WW3/C62b/LQB+muJmEVx8Z49GgIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708672624; c=relaxed/simple;
	bh=Bkd4bk603ROeoJn1sFO0ku4zKRH5VcynJHfRMn7obwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utnlLtEnwMfagr7XO4ZCW8TEqOHYbThfB/36V5BpqVuuqKnNv3GMp5jTc841rzkP+Q8F050l0wTHxTxYVGFmy5AttyLDdX04MKAhZngnxZi1St0knSH1O/ebzcZIfsh1KDVOMHDcE4RmHqPMtOwv5+dHA0qZJUT3ErQOjGiLuME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Vo0aHmpZ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512e39226efso853982e87.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708672620; x=1709277420; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bkd4bk603ROeoJn1sFO0ku4zKRH5VcynJHfRMn7obwQ=;
        b=Vo0aHmpZj4XJmOsmZyH/9hWcyg3zvnixs+nOlbzOvxlzwhHG8pBKL4XAbtSSwMqaS/
         Ka5Bsf/daNAz0oWhObzD8GB8Loa85QjMXQ0gUhYFRYYN8LZr269A8euDSmh4pw/5Dchv
         g4gmCNIzz2S1W3ABGY6HKifOOgpl6KpRUs+dXcJBeHewv3U2mSuYBDXBxQc+s27JNclb
         kj+m1120NcIO6zrAtQOvbiEh/dfH6nzdPnRgou9zeYTRQu+Txhoiq0Dfp5jq+Cf78zZC
         K48CS9pDU5cJr/cwabyGxzgkdTxC9z5bhvi7oVw/OcliJ4SmNOOqL3tO9au5lvz/NzTh
         D0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708672620; x=1709277420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bkd4bk603ROeoJn1sFO0ku4zKRH5VcynJHfRMn7obwQ=;
        b=eHGOZbNUT9H366ktD87uhUm/LyYa4TYwXSEyEtZBLvRBAO0A9FzykC/BzvPXcsHPXE
         lqVfAmtCjWIrh7P/1iOLG3Kg+8wQpNouz1o1zIsMVsw5lGR9Q3L7T89WhpD1XYuS4Hy2
         a93kGfMCo6qcVcyEcW/lrfe7hrrdxDdlOgXxGqcpVUH65twiUspibwUVgu08GSbc8aY0
         XnpU1iQNkuZQN84O1nCIQ4R9BVlAWx6aI7Jkjm90QhTvLTdmnkvARozwZXwWiRgTPpMs
         pJCz1EjISboF/xkfJvnSbK5FBIdqAz710iRgeStj2ZrTAWQUZM1UkNUOSZKurqWuluSN
         ifmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuv1I4qMUR85dprQSGRWVGSvkMx7Unso1mVje7j90EX6sBDmBVdVB4d5Z+CLsnQEqtLx/IwuMO7b0OhQgLkLcqORyf3naX
X-Gm-Message-State: AOJu0YxvzGiKmU9q55im8gg1B7ZqHRkUDa1/IPq/fwwSdhWQP1BqSn1J
	z+rSULJpMqp4uDlMfdc2yN5zNp8GQP1hWXe19eRNtOWDN/nPAGFs5JmLZN3qcVg=
X-Google-Smtp-Source: AGHT+IHcRxHrXIO6oeXHReDoO70Mrm7ktE2Yt8oIRngXxyoGs3oskpHQj7eVseptHDG6vYtIksWckw==
X-Received: by 2002:a05:6512:3b2:b0:512:eb6a:5228 with SMTP id v18-20020a05651203b200b00512eb6a5228mr147878lfp.41.1708672619685;
        Thu, 22 Feb 2024 23:16:59 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id b20-20020a0565120b9400b005116f7d1873sm2330459lfv.301.2024.02.22.23.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 23:16:59 -0800 (PST)
Date: Fri, 23 Feb 2024 08:16:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 03/14] ipv6: prepare inet6_fill_ifinfo() for
 RCU protection
Message-ID: <ZdhGaMacDdcw5H_A@nanopsycho>
References: <20240222105021.1943116-1-edumazet@google.com>
 <20240222105021.1943116-4-edumazet@google.com>
 <Zdd4HbfO2Bn9dfuz@nanopsycho>
 <CANn89iJsmOk7AhGo2+rD53T23+JfQvo7kqg-ARY7d43T683Hdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJsmOk7AhGo2+rD53T23+JfQvo7kqg-ARY7d43T683Hdw@mail.gmail.com>

Thu, Feb 22, 2024 at 05:45:20PM CET, edumazet@google.com wrote:
>On Thu, Feb 22, 2024 at 5:36 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Feb 22, 2024 at 11:50:10AM CET, edumazet@google.com wrote:
>> >We want to use RCU protection instead of RTNL
>>
>> Is this a royal "We"? :)
>
>I was hoping reducing RTNL pressure was a team effort.

Yeah sure, it just reads odd to me, that's it. Basically if you state
the motivation in the cover letter, then in the patches you just tell
the codebase what to do and this "we want" statement become redundant.


>
>If not, maybe I should consider doing something else, if hundreds of
>kernel engineers are adding more and more stuff depending on RTNL.

