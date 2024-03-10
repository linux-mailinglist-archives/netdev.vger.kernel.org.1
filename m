Return-Path: <netdev+bounces-78999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90812877537
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 04:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB10B1C2127C
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 03:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115541097B;
	Sun, 10 Mar 2024 03:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="h6RcaKyJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259C3FC11
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710040305; cv=none; b=HT47QpOFNlYzBuvaV/YIdOuxfeuEddziall5beOv/NW9QA4UbIep3oDitWmlJyuztxT/B94CxRjyMqHifz8tkk3HeBnbm6qPnTmRPZVEb3tBnIrRysrIHw/1hMwgn4GqlXvQo30SGt7hqslR+NdetNOv+N4daer/3bkjoTggCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710040305; c=relaxed/simple;
	bh=k0O8aOMofON7hwEdyTGcg49M6hlUfzrBMF2aU9ei6s8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=rIa/qL3niIhkyR+bth/z1bxPCWKW0PPZsC+YcV6yFlc+PSEjnZ5bpfmh6QFyAFHWB5NSsiYc1KFXxWKwGiH7MQX4j/PTbqWvKqUgYOswzCo8QiHWmqKvpFWq4N+KO5rAcO97jI3qxHXSeTsYSbZg0YTcOAcbROvON1XW7vbiN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=h6RcaKyJ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 00F9848A96
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 03:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1710040294;
	bh=bgqKnLkGWdiqE/bL2JnJDjPNJucGOG+VJQS8gPasnVk=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=h6RcaKyJ/+7HRJQFu3Nf6594f/fEDKZacYfMcDxY+ERQFnANrVDK3S/3jGiKzv34c
	 E6bDkrazH8jsV7u/3jz0QZYhbC2Q7zH3gLjXlQqaOMsHKKvc+MCusUEXz1YFP53H4E
	 awAEpGeCC0krfDPtkOalro6+q6qSwntG+B8ZI1UVYzAdOxYt6fA+5nKYzCP7/qiaJl
	 m+O6t56OVXGxLzdblbF1S+BgcUVel47S3/KF+W+vDy0VHOyCjmpPBlIP5B8KRfl/TH
	 YhnrsdK30Oh5vQk+2+JMN+gSOPDhGes1eKWrjN1Fx5u08BKzTU8mCU7O1t/s9wTX1T
	 bcymmPtzgkQvQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29b99e98a1bso2742566a91.1
        for <netdev@vger.kernel.org>; Sat, 09 Mar 2024 19:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710040292; x=1710645092;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgqKnLkGWdiqE/bL2JnJDjPNJucGOG+VJQS8gPasnVk=;
        b=roX3/NQmwWmXs9RkY5mV+HzLezibst9VRgaf9fXNMEbhivrQvEH9sY8BWpyktOvjO0
         SO9TL3vTQATxKlZvR10zk+jn+Pe5ng1nn5FBmu3K3a1EeeyPvIdckKE2Ef0b7f59YDxr
         U3qmnniNtiyT6mIg07SZmT789UQjqxEJVnOYXeADhsdUx+4ozCrKVz8cxIEjM/Kf0f0I
         m5t1o4edzKNRjjVHPPzUFjbpsq3WbrmlMGKYkjvb+NG5F2nKlcxzl9YyNMvZjYJfxry1
         A9G0c++eSrFWbIaMW0iyWF5suWsuF+xfCDriZ/OoCkaQbVGEx0uoU+GE1RyEesoK2su9
         18ag==
X-Gm-Message-State: AOJu0YzvhKEa41KOsx4B2lbZFDbHtnOTvIkNevVUNR7pRN9CQMHJB+g2
	ugSYuw3wG/PMh990yYulK2Uuzdz2HUfzl9P+bQbgmZfK5HtJ236j65jbMU3Bqz31T/oaYwmYvlD
	jqY/nZdayFqcF5qJfnutEU19TUhbWNKWv2FN7buMhQJK24OoHwsCZ06uDgm6n2CW1Hz1BTA==
X-Received: by 2002:a17:90a:ac9:b0:29a:c4a3:ca0a with SMTP id r9-20020a17090a0ac900b0029ac4a3ca0amr2646910pje.18.1710040291654;
        Sat, 09 Mar 2024 19:11:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXpxKWNKk/6ZJCUcyFSK1OV/FNVKMA/5cWfE4ncjpb5RvrKAdPjGUVHbgP2HDPnIV8X24bLw==
X-Received: by 2002:a17:90a:ac9:b0:29a:c4a3:ca0a with SMTP id r9-20020a17090a0ac900b0029ac4a3ca0amr2646898pje.18.1710040291024;
        Sat, 09 Mar 2024 19:11:31 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id in7-20020a17090b438700b0029981c0d5c5sm1826541pjb.19.2024.03.09.19.11.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2024 19:11:30 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id E37F75FF14; Sat,  9 Mar 2024 19:11:29 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id DC37B9FAAA;
	Sat,  9 Mar 2024 19:11:29 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org
Subject: Re: bonding: Do we need netlink events for LACP status?
In-reply-to: <Zefg0-ovyt5KV8WD@Laptop-X1>
References: <ZeaSkudOInw5rjbj@Laptop-X1> <32499.1709620407@famine> <Zefg0-ovyt5KV8WD@Laptop-X1>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Wed, 06 Mar 2024 11:19:47 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15142.1710040289.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 Mar 2024 19:11:29 -0800
Message-ID: <15143.1710040289@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Mon, Mar 04, 2024 at 10:33:27PM -0800, Jay Vosburgh wrote:
>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>> =

>> >A customer asked to add netlink event notifications for LACP bond stat=
e
>> >changes. With this, the network monitor could get the LACP state of bo=
nding
>> >and port interfaces, and end user may change the down link port based
>> >on the current LACP state. Do you think if this is a reasonable case
>> >and do able? If yes, I will add it to my to do list.
>> =

>> 	I think I'm going to need some more detail here.
>> =

>> 	To make sure I understand, the suggestion here is to add netlink
>> notifications for transitions in the LACP mux state machine (ATTACHED,
>> COLLECTING, DISTRIBUTING, et al), correct?  If not, then what
>
>Yes, the LACP mux state. Maybe also including the port channel info.
>
>> specifically do you mean?
>> =

>> 	Also, what does "change the down link port" mean?
>
>If a port is down, or in attached state for a period, which means the end
>of port is not in a channel, or the switch crash. The admin could detect =
this
>via the LACP state notification and remove the port from bond, adding oth=
er
>ports to the bond, etc.

	Generally speaking, I don't see an issue with adding these type
of netlink events, as in normal usage the volume will be low.

	Looking at the code, I think it would be a matter of adding the
new IFLA_BOND_LACP_STUFF labels, updating bond_fill_slave_info() and
maybe bond_fill_info() to populate the netlink message for those new
IFLAs.  Add a call to call_netdevice_notifiers() in ad_mux_machine()
when the state changes, using a new event type that would need to be
handled by rtnetlink_event().

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

