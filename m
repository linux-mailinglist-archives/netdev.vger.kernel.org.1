Return-Path: <netdev+bounces-304022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N1pVMIwcRmqnKAsAu9opvQ
	(envelope-from <netdev+bounces-304022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:08:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0236F496A
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 10:08:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=LGzO9brO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304022-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304022-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 083BF307CE0A
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 07:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8CB3CFF79;
	Thu,  2 Jul 2026 07:52:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8C3D170B
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 07:52:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978760; cv=none; b=gGuxyJ26sM+ak8DryffyQwFKYiJsQtoHa+dQ5NXC/9eSndD7af1/jOJffoHmgC0Jx/WKwFdIJngYO4SjHcy0JKDnRZEEQoV2voZlWhPpALUwOXVhTlFeDi268IksGnxJRS1YSbVTjQP7wUZZeb4bWVUdBLGFaA0gY0WWH6GCvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978760; c=relaxed/simple;
	bh=tkTbs5WEomVgmghemsBWZ8vvMtlIsS90pwefFFYS67o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHRvzdw6eIbSzsdnMWdX6X3Q9Um27EXlpE5AJK4O0EojSn4rSf+13rfESOZLh/1wU+rBzKTXJpkNU86CBbwbJjCYFKyDPpoyxx0XsMQN+m3+C7NfjdDMKz8i+YlQpXJsuHTkyRESso7LUQM/1F3P5hzRGTcFfbj00jaV4h0RIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=LGzO9brO; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-472326ca506so1089101f8f.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1782978748; x=1783583548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kESoQxWQJP4S+fDdlEQZkP18r4Y5za67xWurR8NPaGI=;
        b=LGzO9brOLsAmggJcjv2mpsSISA3wkiKChF1hBC3mjlzBxpToiPRqxUzAJg3u9PxWn+
         MjJufWTFv3xlPnBH6C9Wf5RtZEeovjxJLea8QpAILr/Y9JZq+9/VzEsYUa3JWf6eY/qT
         eS6IU2T/yluuO1KvWcDr+N5zNvXe3cO4C8XuS/DKDtbI9a3lUoEx3gFjjAYR5rNJIRGj
         LEqpaaMf9EV/eCU4pP94N2bc3oPHvkFuv/hsw5tyGqI5Vs//XxC+xHfePBZ3oxyn06T+
         e1aQhaKzoF7MlUjDEvskQG+XS5e7Kduz4VbzEEVUh7ou3sUSNSNclz4WZNw4OWBLTngP
         SSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782978748; x=1783583548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kESoQxWQJP4S+fDdlEQZkP18r4Y5za67xWurR8NPaGI=;
        b=Hpl2QVhvx+//Byruetsliw5QKQIciPrT+3RNMA7XhPasWE2MslQUhYEI1G/dedmInx
         sNYrQvsytrLpzGgUYFZ41aL1n6kcU2SSPKEwcGrqOEICa2X9Ay/PgxYJ2tIn0dgN8Kqf
         FiFQCZdpEqsHMcr+yNaYmcVEHt6MaiVAKfcQjGCP2FnDiis0FQ7N80HrzTu2sfFq7uWv
         LxA6Z6eS431CmRri04Vfonyx9hAeA8YMOFY4Kol28/bjwjh0JjYYnuS/6OEmJ6sI0cv0
         ZJY99XeE+UuLuMeOCebIVgL+M67i5yC7CKIdf0/+DPsyxuMAbHEzrhaOW4DyrU+RquuB
         9hug==
X-Forwarded-Encrypted: i=1; AHgh+Ro2p37peWytYDjsKDh1uMhb7EBtYJ63/Z6BarAF4HJkZQJeH9lh5Pw4ziulR/dm0Uv6fRhfVXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1Zvj/bmBXlGocBZNDYOL6LGbhdR9TTtQYZRBSZPm32z1xbf5
	9AXINKo+PapvGF9mXB/yyaNi1aOUfX9umBrsXpeaDIrV2vaNiegJWBVml7nCYW6vgGA=
X-Gm-Gg: AfdE7ckcm77pI6oCghv/Ri+zFRB+UzcVky395fUKhvJWHdnPB61vDoKSavi8Z8jYjTP
	5VX/yAK1wPKRo9B2RIRMf9GQVLevP0R045CradNSYW8CwnhDYrCK+tnxzg5HirGT2RQHUfybHuF
	Xp0TRmkB7W8sw3k14LQI2gkBP2Uq9nUIQG5F5n+8VesNQseAPB+ODRZ5Op9UrrEyM67gS1Iocah
	bCMpD5ush/kfaU08xtwS9EawphPTDsUdOG2kvpImIr2jHcuVAuqAWFgVE5MzCtV4IDv3oiX8GVh
	DiHLdjwQpx8wUY+HgcblqHVyMG9U28VWof3iYS9FKSsisX/PPoHvGL28I1Q9f3j66F55nNzmDLx
	XVUtVw71RA5SXBy4QlGLOuj+uSppP0V04WR9Hrh96BbG99RHAJbyqfNVST+xSl4B16HrwP+cl4d
	cPo79n9bg5XvBN4YSBD0fZAjco0fwfKwhW
X-Received: by 2002:a05:6000:4687:b0:475:e015:c2a with SMTP id ffacd0b85a97d-47757e57e6cmr5234114f8f.8.1782978747939;
        Thu, 02 Jul 2026 00:52:27 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94cb64sm6592524f8f.23.2026.07.02.00.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:52:27 -0700 (PDT)
Date: Thu, 2 Jul 2026 09:52:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next V4 4/6] devlink: Apply eswitch mode boot defaults
Message-ID: <akYX4pMrDTnxa6yK@FV6GYCPJ69>
References: <20260629182102.245150-1-mbloch@nvidia.com>
 <20260629182102.245150-5-mbloch@nvidia.com>
 <akThPmvUHvCMT2cp@FV6GYCPJ69>
 <1d4ca929-82b8-4891-9058-1451bf71a660@nvidia.com>
 <akUfXyKioGNAO_iB@FV6GYCPJ69>
 <ecaeeef0-c463-4f10-885a-02ad2d648be0@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecaeeef0-c463-4f10-885a-02ad2d648be0@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mbloch@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-304022-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C0236F496A

Wed, Jul 01, 2026 at 07:42:57PM +0200, mbloch@nvidia.com wrote:
>
>
>On 01/07/2026 17:09, Jiri Pirko wrote:
>> Wed, Jul 01, 2026 at 02:57:21PM +0200, mbloch@nvidia.com wrote:
>>>
>>>
>>> On 01/07/2026 12:48, Jiri Pirko wrote:
>>>> Mon, Jun 29, 2026 at 08:20:59PM +0200, mbloch@nvidia.com wrote:
>>>>> Apply parsed devlink_eswitch_mode= defaults after devlink registration
>>>>> and after successful reload.
>>>>>
>>>>> devl_register() may still be called before the device is ready for an
>>>>
>>>> How so? I would assume that driver calls devl_register only after
>>>> everything is up and running and ready. If not, isn't it a bug?
>>>>
>>>
>>> You would think so :)
>>>
>>> Some drivers, mlx5 included, call devl_register() while holding the
>>> devlink instance lock and then finish setting up state before releasing
>>> the lock.
>>>
>>> In v3 I tried to enforce exactly that model, move devl_register() to
>>> be the last thing the driver does. Jakub pushed back on making that a
>>> general rule. So in v4 I changed the approach. devl_register() only
>>> schedules the work, and the actual eswitch mode change can run only
>>> after the driver releases the devlink lock.
>> 
>> Wouldn't it make sense to use a completion instead of loop-reschedule of
>> delayed work?
>
>Just to make sure I understand the suggestion, this would mean that the
>work waits until the devlink lock holder drops the lock, and devl_unlock()
>would signal it, something like:
>
>void devl_unlock(struct devlink *devlink)
>{
>	ool complete_apply = devlink->default_esw_mode_apply_pending;
>
>	mutex_unlock(&devlink->lock);
>
>	if (complete_apply)
>		complete(&devlink->default_esw_mode_apply_ready);
>}
>
>That would avoid the retry loop, but it also means the queued work 
>sleeps until the driver drops devl_lock. It does keep one worker
>blocked per pending instance and adds this default-esw-mode signalling to
>the generic devl_unlock() path.
>
>The delayed retry was meant to avoid a sleeping worker and keep the
>instances independent. If one devlink instance is still locked, we just
>try it again later while other instances can progress.
>
>If you prefer the completion approach I can switch to it, but I don't see
>it as simpler overall.

Yeah, I don't have preference. I was just wondering. Feel free to leave
it as is.

Maybe, instead of "complete", you can schedule with "0" delay in
devl_unlock? Well, it does not really need to be delayed work, right?
The only single schedule may be done from devl_unlock. That would help
to eliminate the rescheduling. Am I missing something?


>
>Mark
>
>> 
>>>
>>> Mark
>>>
>>>>
>>>>> eswitch mode change, so keep a per-devlink delayed work item and pending
>>>>> flag for the registration path. Registration queues the work, and the
>>>>> worker tries to take the devlink instance lock.
>>>>>
>>>>> If the lock is busy, the worker requeues itself with a delay.
>>>>>
>>>>> For successful reloads that performed DRIVER_REINIT, devlink_reload()
>>>>> already holds the devlink instance lock and the driver has completed
>>>>> reload_up(). Clear pending work and apply the default directly from the
>>>>> reload path instead of queueing work.
>>>>>
>>>>> If a user sets eswitch mode through netlink before the pending
>>>>> registration work runs, clear the pending flag so the queued default does
>>>>> not override that user request. Cancel pending default apply work when
>>>>> freeing the devlink instance.
>>>>
>>>> These AI generated code descriptive messages are generally not very
>>>> useful :(
>>>>
>>>
>

