Return-Path: <netdev+bounces-111711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F71A932285
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 11:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79BF9B216B0
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90101195807;
	Tue, 16 Jul 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HXdX6s9f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D0143875
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121279; cv=none; b=Mv9/vfS3CpKnp7r84ZVrggNO5pYXAVKnWG62PMT7HE/rhCC8tzBzDXm0iRtClh2D+3RK0L0jQYN6S5FbfVxCKxQJedTENj/gr6u1yOw41SNdjEfLql9DJSoaBN1V2t95R0p1IIOIaL4xSO4+GKKGxVrfyHkK9D6QV44noQcqD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121279; c=relaxed/simple;
	bh=cQRUOXRT3nbk5SXR4E5M2ElDKp0uLvZd3NstRhk7yDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLvRzxR8c6kic7r1nAOg9K9iappAEfT/EDZ1lSVBoiMC2/F8QvXWdSEKs7+rkLA+QbOxYcrK/Vv5uLt9Gy6du7LmIFPcjdJf4IAjNL5r5Z8iCjXrwgmFP20LxXVBaBBVXKpTUoDOcUjnvYZi57f3pHdisQX6z97iAESdOvTqs8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HXdX6s9f; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so1888852a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721121276; x=1721726076; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1F/ZpSl0ICqlO5c3jFxjhRdSZxvasTrherRTPCYwpKc=;
        b=HXdX6s9f2VR5DsPz5NgM9jZr+Ov6Ue0XCivIFDc9UO2NT+683O7w37nfqkiCeG3Uqa
         DS7PnMvtm0QSQTp06yr7EDMprCmTVSONnUul8Qnat6jHDN2F6qkhNhLx7IhytwuVbM0c
         KH2ebRyf0ea9VaIE1W1n/xVJMIdTqoaqTWueAAD8RpI/QnYaMrb5C5GrsJNPeYyjt35U
         On7pmIMcdohHYilKbfs1PY5cqlZpHmpQHB7WjsMbC6PYYPNBhJo0364KR6DaKzSde0h7
         D7fRew13IX7i6Jj8gT58hzh+af/NrlSp4qr9mpGVaxsmJ8HUc6DpcMobDJQ/EeGIcmjl
         2DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721121276; x=1721726076;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1F/ZpSl0ICqlO5c3jFxjhRdSZxvasTrherRTPCYwpKc=;
        b=IpgmCAyBVELDk7bNtaKleMaB/NX9Jv4avaNJt2ToiBgyvloa9a5Z+/8pO+/Q13OtsS
         lZTgDHWA284rsLjeuTRVTplP7Ojoj3ydtj6ju6He0ggSerAhd/fT+RA00Nx6zUwzQqvD
         uuZCPA5rRQO3GIAtSTTkzzj7OBC6qKfDOEDIcs6rLFK0hil6b6di9wLqntUTUoPaYDUN
         e53Y0FIdW18o2nRmSWXnRdyPGL5zBblrYrTDdrUytXAlpOjeSwz3vj4jiWg9M+Yo2eN9
         zwczkcG6IEw6WW7jLGyTJKXP83oYpljWR34VIO8+hom1J2c2iQm65JFB1SEqyM17nfXb
         1wBg==
X-Gm-Message-State: AOJu0YwUc1Z1OaDTkDiu2NuN9FWyJAt3dS1ne9ialSJGhoEKr1O0SpNe
	fc/scN+bXnt3DV8G2z27diUltu++3fGa35eaWprWscQ/x8QLoUOdpigEz00DmSz1JW8vcU9Un4H
	AEmk=
X-Google-Smtp-Source: AGHT+IGp1X9SF267zobXjwAU0nsjmxrbtCIMCWMxl8pWqlpiJzN4UPBYNOy39/tdXp8BHOAfTHjsDg==
X-Received: by 2002:a50:8d15:0:b0:57d:1595:f6fd with SMTP id 4fb4d7f45d1cf-59f0c91e614mr1052995a12.18.1721121276122;
        Tue, 16 Jul 2024 02:14:36 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24f56fb9sm4433282a12.24.2024.07.16.02.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 02:14:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
In-Reply-To: <a4edd3d6-4cad-4312-bd20-2fb8d3738ad6@rbox.co> (Michal Luczaj's
	message of "Sat, 13 Jul 2024 22:16:11 +0200")
References: <20240707222842.4119416-1-mhal@rbox.co>
	<20240707222842.4119416-3-mhal@rbox.co>
	<87zfqqnbex.fsf@cloudflare.com>
	<fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
	<87ikx962wm.fsf@cloudflare.com>
	<a4edd3d6-4cad-4312-bd20-2fb8d3738ad6@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 16 Jul 2024 11:14:34 +0200
Message-ID: <8734o98zr9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 13, 2024 at 10:16 PM +02, Michal Luczaj wrote:
> On 7/13/24 11:45, Jakub Sitnicki wrote:
>> On Thu, Jul 11, 2024 at 10:33 PM +02, Michal Luczaj wrote:
>>> And looking at that commit[1], inet_unix_redir_to_connected() has its
>>> @type ignored, too.  Same treatment?
>> 
>> That one will not be a trivial fix like this case. inet_socketpair()
>> won't work for TCP as is. It will fail trying to connect() a listening
>> socket (p0). I recall now that we are in this state due to some
>> abandoned work that began in 75e0e27db6cf ("selftest/bpf: Change udp to
>> inet in some function names").
>
> I've assumed @type applies to AF_UNIX. So I've meant to keep
> inet_socketpair() with SOCK_DGRAM hardcoded (like it is in
> unix_inet_redir_to_connected()), but let the socketpair(AF_UNIX, ...)
> accept @type (like this patch does).

Ah, that is what you had in mind.
Sure, a partial fix gets us closer to a fully working test.

