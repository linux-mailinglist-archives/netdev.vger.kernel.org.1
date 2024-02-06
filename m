Return-Path: <netdev+bounces-69543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4762E84B9DC
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27AF28323A
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F60C133426;
	Tue,  6 Feb 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZS3BxqNV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D672818EAB
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234052; cv=none; b=nh8O7OVhMcUCJvYKBfYYuYuwsDzjtxMuqPm11h5Corw22NvqIO6MqsoeJmLte8pZMQRL4ludCXd8tRuSzM0drgdxQFDpl4FyNQVbUHdV0tCFh5X8mgLJ2zrZisiWKnXoHRED0rGk+M0z/5fdnjRVUWgfvg4ktXuQ9TkINdF2lVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234052; c=relaxed/simple;
	bh=Tw9mDUBtNP0BrDPfzJF7VX87v9ZUy752dtcldLBfOV8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=u81aGJ5cLUaWX6e4NzfVmoMl5D6XJPy9vDJivuWXSH4PS1zTJRZgmdAIy8APsMzDJw8GM1WRLlet/OYEkfMC0yuA0yqeALNEhWKOI3uvyR2XHWcPUfLzOC4lTUgD6wjwogcIw5lxhJBcT5Y5KJbL8XwLQ9Q5AcuoGGAxmhK/8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZS3BxqNV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707234049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n88iFnKY67YOPgdWJeamuFvI6GAastNi1Kt27+2JVpc=;
	b=ZS3BxqNV6cGNdzPE8UURcltQEN2aOcPR35toGwzq7Hk2jGT8nJBgyC71Ua2BO79n2njzIz
	sylI/WAxIJh3kebX6uk50E1Y9m6PYALvq1m/HwVRhavqb0KzxF3LeInnL7NXeTjmhkosH3
	IRfrOXVPBwA5wrmblTyXzGRANMLmsLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-TEXFpg2ENwyMv2Nk4_Pw_Q-1; Tue, 06 Feb 2024 10:40:44 -0500
X-MC-Unique: TEXFpg2ENwyMv2Nk4_Pw_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 289D3811E79;
	Tue,  6 Feb 2024 15:40:44 +0000 (UTC)
Received: from RHTPC1VM0NT (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A9DE28BCC;
	Tue,  6 Feb 2024 15:40:43 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Pravin B
 Shelar <pshelar@ovn.org>,  dev@openvswitch.org,  Ilya Maximets
 <i.maximets@ovn.org>,  Simon Horman <horms@ovn.org>,  Eelco Chaudron
 <echaudro@redhat.com>
Subject: Re: [PATCH net 1/2] net: openvswitch: limit the number of
 recursions from action sets
References: <20240206131147.1286530-1-aconole@redhat.com>
	<20240206131147.1286530-2-aconole@redhat.com>
	<CANn89iLeKwk3Pc796V7Vgvm8-GLifbwimPJsDTudBZG-1kVAMg@mail.gmail.com>
	<f7t5xz1k5h4.fsf@redhat.com>
	<CANn89iLjHcLGvvRLVBnmk7tXXgKagS_t_VnetWkjs=0rhKtnJA@mail.gmail.com>
Date: Tue, 06 Feb 2024 10:40:43 -0500
In-Reply-To: <CANn89iLjHcLGvvRLVBnmk7tXXgKagS_t_VnetWkjs=0rhKtnJA@mail.gmail.com>
	(Eric Dumazet's message of "Tue, 6 Feb 2024 15:56:46 +0100")
Message-ID: <f7teddpiosk.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Eric Dumazet <edumazet@google.com> writes:

> On Tue, Feb 6, 2024 at 3:55=E2=80=AFPM Aaron Conole <aconole@redhat.com> =
wrote:
>>
>>
>> Oops - I didn't consider it.
>>
>> Given that, maybe the best approach would not to rely on per-cpu
>> counter. I'll respin in the next series with a depth counter that I pass
>> to the function instead and compare that.  I guess that should address
>> migration and eliminate the need for per-cpu counter.
>>
>> Does it make sense?
>
> Sure, a depth parameter would work much better ;)

Okay - I'll give time for others to comment and resubmit in ~24 hours
unless there's a reason to submit sooner.


