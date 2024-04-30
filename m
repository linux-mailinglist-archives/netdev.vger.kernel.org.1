Return-Path: <netdev+bounces-92332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCD08B6AF4
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 08:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B57B2820A7
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 06:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081F41BF20;
	Tue, 30 Apr 2024 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Mz1aQHJx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72131BC35
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460227; cv=none; b=OYZE/e4I8L04yoS+0PrurocxS7bSkrRvhGdT7SW2IYxR750YbOTx9fHO1FhIxFXwIfRg8+KmISaggUpFtwS0dz+Ljz2FVfMYkf56WUvYFU/I8sFGQWH2wAOj2iQTZo1l9FheQe+E/NgN22BchZzLr/fY40NQbBOloyk+/ACbUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460227; c=relaxed/simple;
	bh=RIER2WvaRzlpoin4ttKrbUvzJsxNJZ81t+tcedDHBns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qf7sKMOUYoc6T9ryYKLokZkoJe+f2XReb6sZ1mXQZT62sWQGa+5VENTBEUmk1gZ1yoLWWEEIAsxDeaFKjZxz6wIir5MkscQcPcNwYejn+RQqteFSG14P4wa6yhKMFo7OmSVSlTn/RJK9Ot8ItzyFxX7NmfHwhFtbKHaXljF+hF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Mz1aQHJx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a58772187d8so637022566b.3
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 23:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714460224; x=1715065024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FVgR1Dca7XJuk7IfME3aBiJ0pOrXTj6aIOqyadopmE=;
        b=Mz1aQHJxbZalGnPb2m7UDQ7NBpeu71j4NiKjcze8vZ/i8TIjRyqw+jAJECRkhJCcAu
         HIqHytcb4/t4Njtjnz0R5bXcgUIAO0TJv2lJ1XFxrxRlxBMHgk9BTssuMZeONKlkQGzp
         bSs15ijyOzgvoFBfGnUOHQjYIr9aPeP9gAjiWhGCoUwMfueObTfpMjLeshJoGbNld7f8
         ecWD71VHtz5WzX8kXqYZnME9pzyS4WGGqcCjpxS1jhP3p/I9IX5q+JoP24NaKa9WrhDU
         9WoqcQ/TetwN4SmrTq1reMRAtTXpqOAzU8u/rLUG8rF7w8MFl0HGFaPnkoEpxxb9226g
         mTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714460224; x=1715065024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FVgR1Dca7XJuk7IfME3aBiJ0pOrXTj6aIOqyadopmE=;
        b=DnP/uMlWWAGi3yw/c7NiEGf0bEqlKG5ZcT2kpztLZ+oXVeCxY0UE3UhFCH4TtzdCjA
         pKoa4nyEMsXaxuAkAcRxz9bDfapuzDdw8byfq3ky9rP4XkHjBDccRiQnTBVyicdnESdj
         vIMf0Abdy2geXlC1aw3puUZv6uzKEW2DUP5sqDz4oCbE5zNeZ4oCif4VYUMJ+yqd/Y1F
         SiUBdtm4CjG81O9Qbt8DWoDYDQK17qVg3BvzpGnaoELtsGBpOtETQkZqxlTw7QUx/LDy
         9R3xC4nxjZHairpTa+OniCSLn7KMxd01R9Myn/nHT33pc32WiSaLP/QAO0VhIl7Jjr1v
         kryQ==
X-Gm-Message-State: AOJu0YygIlgJ/k9GU3usypab0w4uJhCyIuaVpfbJtjSRelRKhffcA3j0
	q2qrSCKNenirrExqn+RHDms5mmgcZZMLmi8Y9IYtO/1YTMIcs/ZmTAa2Tb/hm08=
X-Google-Smtp-Source: AGHT+IFrFHeHXzh/hc5I4ZUwY8RPWgtyTjn4NhRcMXWKKg8DwzJaQW+uzv7T/QzmolLZYjZ+a/rPaw==
X-Received: by 2002:a17:906:3597:b0:a52:6a33:2ea4 with SMTP id o23-20020a170906359700b00a526a332ea4mr10321515ejb.54.1714460223757;
        Mon, 29 Apr 2024 23:57:03 -0700 (PDT)
Received: from localhost (37-48-12-67.nat.epc.tmcz.cz. [37.48.12.67])
        by smtp.gmail.com with ESMTPSA id o20-20020a1709064f9400b00a51e9b299b9sm14689394eju.55.2024.04.29.23.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:57:02 -0700 (PDT)
Date: Tue, 30 Apr 2024 08:57:00 +0200
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
Subject: Re: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
 representor netdev
Message-ID: <ZjCWPEony0Q22AEt@nanopsycho>
References: <20240428105312.9731-1-gakula@marvell.com>
 <20240428105312.9731-4-gakula@marvell.com>
 <Zi-Fg7oZBCtCvbBA@nanopsycho>
 <CH0PR18MB4339BF5712F2E93835E1EA08CD1B2@CH0PR18MB4339.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR18MB4339BF5712F2E93835E1EA08CD1B2@CH0PR18MB4339.namprd18.prod.outlook.com>

Mon, Apr 29, 2024 at 06:13:56PM CEST, gakula@marvell.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Monday, April 29, 2024 5:03 PM
>> To: Geethasowjanya Akula <gakula@marvell.com>
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>> Subject: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
>> representor netdev
>> 
>> Prioritize security for external emails: Confirm sender and content safety
>> before clicking links or opening attachments
>> 
>> ----------------------------------------------------------------------
>> Sun, Apr 28, 2024 at 12:53:06PM CEST, gakula@marvell.com wrote:
>> >Adds initial devlink support to set/get the switchdev mode.
>> >Representor netdevs are created for each rvu devices when the switch
>> >mode is set to 'switchdev'. These netdevs are be used to control and
>> >configure VFs.
>> >
>> >Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>> 
>> 
>> Are you still missing creating of devlink port as I requested? Why?
>Sorry I missed your comment on earlier patchset.
>Wrt adding devlink port support, our plan is to get the initial patchset reviewed and then add 'devlink port' support.

You need to do it in this patchset. Rep netdev without devlink port is
unacceptable from my perspective. Thanks!


>Will submit 'devlink port' support as a follow-up patch series.

