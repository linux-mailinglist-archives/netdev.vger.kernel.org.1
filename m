Return-Path: <netdev+bounces-158281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56E4A114FE
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410853A502B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4A12135D9;
	Tue, 14 Jan 2025 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kQWb5C5E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F202144B8
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895938; cv=none; b=DsT8T/dnlapC6HMkk6FDalI9vB6FDg93+UpEMO+mO65YOENuzek9dgu9wODne3PkqzKWn3BHeJCHnah6JdEQOCCIn/eRHeHGu+MgHMt0yQoxda46tiu/VDBQk9Jdfq0PMyF5nlyIBlfmlDbYeJFwI3LSBoBSXlEi3ujQIYRWaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895938; c=relaxed/simple;
	bh=fxFy3m5kJMu3csQt2lA+JCHgmAiIN9RQdZrF79UNK/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eav5eNRV/J35odAmwHsLwRwwfvhENcaaNa8lTLhmBKJklmRd59VkklJOJ6gw8bmX8IUtaqdWTjptwMAxOsv3byKYKaHUpq+D/obj2vLBnV7XaoEkyQOW7BJOztTu2Lja+pbkuHJgPgZEh8LsVigofao/LTHEVdFY1Ss/j03/A6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kQWb5C5E; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2165448243fso131904345ad.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 15:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736895935; x=1737500735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zu9TxN8cewl5TMnElQGY/fQBE5feadWiIc6xuCz6JzE=;
        b=kQWb5C5Ef/25cti+s73J7nznJMmImi+ls0Asq/3cyJsZQfJPgUUbNmDH3f8cpu/Qy7
         3JO6m3Qy7PhVOgtZaqzpZ6RbBrXQggBtF32Afmc6QimszY5CD4wUCU4V3WhA1/h//Yai
         VtbGNk9TinLea+3JO6W4tzaTTBFuOYlSf3SG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736895935; x=1737500735;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu9TxN8cewl5TMnElQGY/fQBE5feadWiIc6xuCz6JzE=;
        b=UJVjZLA8u48Xmut3gZnn1KzRELEgsHeTFLCT59BhXgeImMgAI+keZCtTnaF4Y9F+5o
         f7utNRTnhQGNBptqNfWvOSTATIyLeH8zafYQgUHzgqKhB7EiVJCLPm1u2JQk5OZHJoEZ
         g88KPT9r1aWunkIR6pS0l3+B1BKAQ+a333HVdHsn4Tq3WdtM0F7ThLZz6EnCMJRYSQQW
         PiPwqq/aPlJqGs36SL03t6hn5DWfBmvpX0dzrV5PtNgf69r6ogKiFe1zn5ZsOqY1e0uA
         RozspRUwEHRVv47EDODPGOTiONPtfuasYNFbpepz2i4E2OkAj5XJiA11P2PyVbY8XFxd
         F/LA==
X-Forwarded-Encrypted: i=1; AJvYcCU71y2ZLC5hbuOMBlceA16J1bj7J/FlE1+YMYcCH8x7z6YJdw8Yfs++/2OAhPmelbtQ8gIPVmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJejOdevB5b7xwM+ZON+Mnyp0/cWuYm5C42RGDDEAahouj7xfu
	vAH9e1auw0cNWq3dUJxJEolb06iZRk2/nXEgG45sPTTdKpWrWQiRs62arMKSRn9Fj1NeV59+kb/
	b
X-Gm-Gg: ASbGncuNirORPDYD1EObd96JQg1QjnbhAG8S/0k9RJ3SC90wOev1TTCCp5ItHsFNiqN
	xDFExGPM2Zw+1nkYO4ZmKMtQYSlzlG6UPgtWADasSIFh9AZgLBp15k+NhGe/l5XWEskijR/dqWs
	gzMxQWpO3TVcxneOMTPYbevybT+Wi4FgAQxmT9JEb5mJIl/qJzri41IE65oWuq/63y49ZLpYENU
	AHE1EdQl7TDgYseNfrJ1xAczz8kcNzgz4n5+3YvyJNwaTbG1jvLOl8/ijxH//xS+H3k5fILjoSK
	4wlR+DLGjsMr7ebH6jMMYsw=
X-Google-Smtp-Source: AGHT+IGo3hZUN48nFDUhOJVchrLKqO5uvBriv1n6T7zhBIJWv8cXvurhorCebK3qJN1hLPfoUm1jvQ==
X-Received: by 2002:a05:6a20:2594:b0:1e4:8fdd:8c77 with SMTP id adf61e73a8af0-1e88d13b502mr46135021637.8.1736895934711;
        Tue, 14 Jan 2025 15:05:34 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317aecb2edsm8650628a12.14.2025.01.14.15.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 15:05:34 -0800 (PST)
Date: Tue, 14 Jan 2025 15:05:31 -0800
From: Joe Damato <jdamato@fastly.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tsnep: Link queues to NAPIs
Message-ID: <Z4btu5YT8I9fQlV2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Gerhard Engleder <gerhard@engleder-embedded.com>, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
References: <20250110223939.37490-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110223939.37490-1-gerhard@engleder-embedded.com>

On Fri, Jan 10, 2025 at 11:39:39PM +0100, Gerhard Engleder wrote:
> Use netif_queue_set_napi() to link queues to NAPI instances so that they
> can be queried with netlink.
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json='{"ifindex": 11}'
> [{'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'rx'},
>  {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'rx'},
>  {'id': 0, 'ifindex': 11, 'napi-id': 9, 'type': 'tx'},
>  {'id': 1, 'ifindex': 11, 'napi-id': 10, 'type': 'tx'}]
> 
> Additionally use netif_napi_set_irq() to also provide NAPI interrupt
> number to userspace.
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --do napi-get --json='{"id": 9}'
> {'defer-hard-irqs': 0,
>  'gro-flush-timeout': 0,
>  'id': 9,
>  'ifindex': 11,
>  'irq': 42,
>  'irq-suspend-timeout': 0}
> 
> Providing information about queues to userspace makes sense as APIs like
> XSK provide queue specific access. Also XSK busy polling relies on
> queues linked to NAPIs.
> 
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> ---
>  drivers/net/ethernet/engleder/tsnep_main.c | 28 ++++++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)

Sorry for diverting your thread with the questions around XDP.

Based on the conversation, this patch looks good to me.

Reviewed-by: Joe Damato <jdamato@fastly.com>

