Return-Path: <netdev+bounces-276354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n7DUFKwS1mnnAwgAu9opvQ
	(envelope-from <netdev+bounces-276354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:32:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9D3B9160
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 008C03059319
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957223A3812;
	Wed,  8 Apr 2026 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idfZ0HeG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7K2mlr3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8693A4524
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636909; cv=none; b=ms606FOqGhf9XEEvnczRgZ/mPIXlDdMRKr5w73aWSj7JEjkuxp0+1jdBvbAosunDiLZYm6OgLcPNgCUV+uqZ9BIa3cCzc8l54YANoy66ghzCgThGto2xfdrs6m6fXebPkbNHAhZqroU3/vIfU+NzIm1nuUFBO6adBK/oHXFRkdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636909; c=relaxed/simple;
	bh=vlaONbgseMAZgWwparintGRzVwHOQi9Gyw4NSVS+ovY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipzlrVPpVeKKI5jGVDPaJk4ZS6KFCG5TlxrpLZeqtcadRpEdvoGDotiu2lJiiGm7uW7qQbow9G8F3iYGTuIUwKX3HmxuXqCyRp6P4EOg5UB50JE9lqTqrJsqGytour4R8ykENJcM6xwu8R6CKFSBMe/8l3x02agaS6IAXq1ZllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idfZ0HeG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7K2mlr3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775636907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ANYxXRPm7mcXJAwc8SfGf0BegLgl/O90UoI4kqmm5Q=;
	b=idfZ0HeGdneUx2rtyWkFQCNZ40JUIyCyJK/JeF56xCMotsdd7tEC7I3o72/RqMkb6j4DDt
	Pc/XVJNkXDbCc7YDSOs2yLtoOaJrHP4NIow5mQUiDGYLoXAAYtD89QOVteaiN5rm5PsNTx
	7B0gBci+vJniFQROB86GCwsbiPhYBjE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ArhfzcyePf2gHvPgRlUMnA-1; Wed, 08 Apr 2026 04:28:25 -0400
X-MC-Unique: ArhfzcyePf2gHvPgRlUMnA-1
X-Mimecast-MFC-AGG-ID: ArhfzcyePf2gHvPgRlUMnA_1775636905
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d03bad787so6156686f8f.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 01:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775636904; x=1776241704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ANYxXRPm7mcXJAwc8SfGf0BegLgl/O90UoI4kqmm5Q=;
        b=R7K2mlr3fhjY9JrWDvBukW4sALgNe3ggKwerrhiF71bZQ6hUwNU9nkkLMCNG6PxZZl
         mZtvIydpIlQYIJg83kcANR5J3++gdQEpdsXE6tSTt9c9jP60oKNG/ztMgMe/bl4P9q8c
         CN8s6zjU/vCVCNelO2+v/JKKFpxrv/c0xcX7Wbmy28xai9a4n2EE/Vy7tBLkZpvX3cwf
         MQcePhs2FL04xwxzijQ/Q8KSxFfzqJtGWx8vPsdPXFfneGjzyy5RBKA9l4tDXeVNmcKK
         wAIAL1tcU4L9ks8NNbvlRDmmKNfxkLV4HMW59DhZnzUgtD2Lptjw72EaH1WA7/ARR8NO
         CnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775636904; x=1776241704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ANYxXRPm7mcXJAwc8SfGf0BegLgl/O90UoI4kqmm5Q=;
        b=G3AIMQhwJa1dB3qoVHbUO7p3dJMxZvnd/mGVWCHKIc+O4E8+mOz71hdck8SyWt8Uat
         g0mYMc5PHYxOp5Ib3iJPGabAfSP5lqVnAGReAAT++uTcpD3GcXzrP9EwrCFmGtbHc3Z5
         hqjYmz8dXNSmMAuyF5vfMKkIl047NeDoaoDlwROgkUvohg0LmSPMxs3uaYuEeK/Q359O
         DFWwTwIv/BAjljAQ9Ag115vGNAlmgb03dt6eB0Gua3nmPbBrqbxXvcLw+8LsoQ3dhKHf
         Q3khFRTqpRHLqM4h8yS3Xtz99R7Vx0z5HhgnSir5jqc/9+E894qG2y2JZZryxa8ghY5B
         SqOw==
X-Forwarded-Encrypted: i=1; AJvYcCX4A7Jo8u5DxEo74gLcq6ftrgcqpEMjAAV8q+YOwoR0XXG7eKO9nOp8i+6vkwAYoY70e6E44Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywzSqRWXZWM8VRK9bkf5s4D4NdEYLftaY7t07LIcYaiZ/ZlWYi
	o8R4GKskIfzWipm634pvXNDLdTT9puHsOh7cK5vm5bjbZpRANkdYHbnuSxadda0V3QSSoLkG/FN
	uoIkDWnAR2NI6tcCdGG7WFfHKXMSBQcmzzdj2EDCp3M+2q0ZG3kWFzYD6yg==
X-Gm-Gg: AeBDieu5zttOt+mlleqa2ZqcXY19vZMcqWRyfO1akLk4ysNFfdC5FCEUEcjtU64TkYx
	L6Y0F01sSxtOI7Pj4534GqA8zmChGkUZo2HzNOpp0FLlpRBgN4NC5SO+AMidnuZpP2Dsk7yr4mD
	aR01CLPScxNFiJAO3Gl0kXsXmEOCumS/NpM9MLn2LYJuC8zdNwyq8goSSuA/XBGxmsINDGC5bmo
	4sYz/D+0K7ezFLOYZh6MUMDUVX8Pb65brbP1wUsIzgyj36SC4vmztDSmV34u6lTOeyoSYx2qtJL
	MjBFYERELSoLHgNqKEK2KesS2YWjN2SouctN0YKicVQKYbY54auiIIEAGFNOnsDfmqabUeo+rxU
	ie09ow458pM7Gs2yqqBwZ
X-Received: by 2002:a05:6000:1789:b0:43d:1bf6:30f7 with SMTP id ffacd0b85a97d-43d2927716bmr28411489f8f.18.1775636904371;
        Wed, 08 Apr 2026 01:28:24 -0700 (PDT)
X-Received: by 2002:a05:6000:1789:b0:43d:1bf6:30f7 with SMTP id ffacd0b85a97d-43d2927716bmr28411443f8f.18.1775636903838;
        Wed, 08 Apr 2026 01:28:23 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5419sm66685938f8f.11.2026.04.08.01.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:28:22 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:28:21 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Xiang Mei <xmei5@asu.edu>,
	netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH net v2] net/sched: cls_fw: fix NULL dereference of "old"
 filters before change()
Message-ID: <adYRpRrnIdUnglAy@dcaratti.users.ipa.redhat.com>
References: <dcd085bd504ec1d0698690e08e2e1c4d0edff8e4.1775232030.git.dcaratti@redhat.com>
 <CAM0EoMm2MpiZ-Rn7PVE8rYq8bOkrqs+0PAjuLi23iLN6Eih2sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMm2MpiZ-Rn7PVE8rYq8bOkrqs+0PAjuLi23iLN6Eih2sg@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276354-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dcaratti.users.ipa.redhat.com:mid]
X-Rspamd-Queue-Id: B4D9D3B9160
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 02:59:22PM -0400, Jamal Hadi Salim wrote:
> On Fri, Apr 3, 2026 at 12:04 PM Davide Caratti <dcaratti@redhat.com> wrote:
> >
> > Like pointed out by Sashiko [1],
> 
> Just found out about this ;-> So bye-bye old AI? ;->
> I must say, finding this specific bug is impressive.

[...] 

> Observation on consistency pov:
> You will always get a "q" when you invoke tcf_block_q() if there are
> no shared blocks attached. But that doesnt mean the "create"
> configuration is complete; it is only complete if step 3 above
> completes. This is because we are not sure if change() will result in
> "old" or "new" lookup setup. So the check you added for q may be
> inconsistent from that perspective and fw should have returned -1 like
> all classifiers...

"Hello Jamal, you are absolutely right! (emoji with fire) However, ..."  :)

> I cant think of a simple solution to verify if the config is
> "inconsistent" other than to add something that gets checked in the
> datapath (and when absent, return -1)

^^ This. Specifically for cls_fw, that would mean converting fw_change() to
allocate some control data also for the "old" uapi, and I think it's too
much effort for the legacy.

IIUC the inconsistent behavior is: for a small amount of time, fwmark
classifier used in the "old" way would classify also when the filter's
'handle' is not zero.

> From that perspective, your check is not catastrophic, so it may be ok.
> At minimal the Fixes: needs to change to Vlads commit? Good news is
> only fw _seems_ to suffer from this challenge...

This is also what I understood by reading the code. Sure, I will edit
the Fixes: tag. Thanks for reading!

-- 
davide


