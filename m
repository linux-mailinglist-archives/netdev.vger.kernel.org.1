Return-Path: <netdev+bounces-189654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D9AB3125
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A373B29E9
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA65257AC3;
	Mon, 12 May 2025 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSVKx519"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C9257441
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037427; cv=none; b=fAK87HGWRRxrKDaTKL++h0QIsub2o2mwxaO5IQCWj6kaHeU1LN67eA9dZj6gEwIcxn9E/h5+CDR99zqegthp+m0cVPYdhC97WEJ8njxaTWmU4iDNv2+sPbRq4gW3U3SzEZA8WmGpqXfwRuR3So/+ECpZntD5wunzPY665DOlIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037427; c=relaxed/simple;
	bh=9V6vDdViy3d2O3mDqe6gPiwcwQT0BJMFk2Cu62wHlm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZAyjWXrEQmEx8WMPd7cuCTj9NRFN176phhfhXaKFfq4kpp2no6HJflezQRqCZJW+q7hZUwciYI/UtBsiNfzPe/lyofTjdxTrNOdA52aYzbXBDug2EZhj0SdbEDWO7G4cYtfUJEm+8+h2GQML28WrxibATv1DbcTx0aFNFIMXtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSVKx519; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747037425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5+S02rIdjO6W5FD4Sr6YnC+GymDvPowQYf/Bp7QCACk=;
	b=eSVKx5191e9fqtGK2LoeOXvvCiXaNt2D17/ezgudClzSEO/57VN9CX7QsWTiJL6VxLn4Gf
	o+/NzkvXucFfo3wbP/ly01R6QuE9n8dyBI9i25N7uScwYJMmURrNa8F6P/bhMrdQGw6r9o
	Gv3vrvzcyQA3EZCnq0Dvcv3Uri6OB+A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-9N0uN8cgPL202OGmbWAFEw-1; Mon, 12 May 2025 04:10:22 -0400
X-MC-Unique: 9N0uN8cgPL202OGmbWAFEw-1
X-Mimecast-MFC-AGG-ID: 9N0uN8cgPL202OGmbWAFEw_1747037422
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ad215354231so366457366b.2
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 01:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747037422; x=1747642222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+S02rIdjO6W5FD4Sr6YnC+GymDvPowQYf/Bp7QCACk=;
        b=lwChxwnOL+Xl96jRiedFTsSXmUQWWHAOni+uB5KwNME3jGKKpHhLUP5Kv66sXUv3nb
         iWXnF/lZzV7W9mbyrayqD1TS2JQfcYiYlk5mjlzjGvdf1nbtAAEptMRc8xgH5hjJW/ZL
         9/RtUMS65GgjjJCYc/zvP5tFwTF6J5esjszYKL0KOIg76bUN/2DLiHwly25jVYYbIR3X
         tMVM+LFT6lZwLng6bwzzRobBxzgLcxrhpEvUWEc6dZIjX3/pB+H9y66PwbWzlAGi7UTi
         WL4B417DE8j6Auf03hndqqF6zGf5pVrbwFe+NNJm5gIMwx2WjnJfYd0kU34uauWqBfiJ
         bzTw==
X-Gm-Message-State: AOJu0YwMNW98vejE1x6jLMoTthDJWxp1iiTS+jEiH3VPgqRAEPBTOkH/
	JMycj7ahQZYNdJVN9n9P1jkxam1xYfZ8+4VCL0KdBK8FXAP9/LcptEGk0ZluGciZYM2HlWMUGgg
	dzOZHqvMnn0TfZZig71GZpC4pnBMS0vDuaCOzAwQSvtB+/J6wZOzPzA==
X-Gm-Gg: ASbGncuQM5YYpgEOWtnxDqMMPokFW3rYb5plutJOTeymxiuMKvbT6FSmcsN6pIsJLfN
	40lh27XYrnC16lH9ehuhNoIU3/fHGhWP6pxsw2rQ7QfA+dUcKAACD4R/YF6Sdxxf+rYoP2Txj4i
	FK0ob19rFrXV0mw7ONzxEc/NWW5AePfD1UoT7VyX4vNt9dkOOS8VDrLNZ933noyO4fEIoM5D52M
	LBvSgrj969tekLUzmTQw218ux8db4PWc5alFOA1vpeOQgCfEq+CKtC751lFCPgfW5eQ81RJlvQS
	AGjGH9XfIS6yAis6SnhE0SNe+NMniz6Q0a77lF+n//zzZLs+d5mDIxqXhx4p
X-Received: by 2002:a17:906:3590:b0:ad2:2a5d:b1ab with SMTP id a640c23a62f3a-ad22a5db4fbmr784532666b.59.1747037421577;
        Mon, 12 May 2025 01:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMO8Q+6CpMt1CLsFQqVeR5SPzSS1kxASsQGqyh0PT2VydsliSWr7mhdlhPkcBKgps3LdhAVg==
X-Received: by 2002:a17:906:3590:b0:ad2:2a5d:b1ab with SMTP id a640c23a62f3a-ad22a5db4fbmr784530366b.59.1747037421144;
        Mon, 12 May 2025 01:10:21 -0700 (PDT)
Received: from [172.16.2.76] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad23a5552a6sm384024366b.30.2025.05.12.01.10.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2025 01:10:20 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org
Subject: Re: [PATCH net-next] openvswitch: Fix userspace attribute length
 validation
Date: Mon, 12 May 2025 10:10:19 +0200
X-Mailer: MailMate (2.0r6255)
Message-ID: <36984A9D-1811-4F33-A6C4-310E44613E2E@redhat.com>
In-Reply-To: <12cd8c5b-d399-4cc5-8b20-d80d567ba0cb@ovn.org>
References: <051302b5ef5e5ac8801bbef5a20ef2ab15b997a2.1746696747.git.echaudro@redhat.com>
 <12cd8c5b-d399-4cc5-8b20-d80d567ba0cb@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9 May 2025, at 1:07, Ilya Maximets wrote:

> On 5/8/25 11:32 AM, Eelco Chaudron wrote:
>> The current implementation of validate_userspace() does not verify
>> whether all Netlink attributes fit within the parent attribute. This
>> is because nla_parse_nested_deprecated() stops processing Netlink
>> attributes as soon as an invalid one is encountered.
>>
>> To address this, we use nla_parse_deprecated_strict() which will
>> return an error upon encountering attributes with an invalid size.
>>
>> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
>> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
>> ---
>
> Hi, Eelco.  Thanks for the patch!
>
> The code seems fine at a glance, though I didn't test it yet.
>
> But I have a few comments about the commit message.
>
> This change is not a bug fix - accepting unknown attributes or
> ignoring malformed ones is just a design choice.  So, IMO, the
> patch subject and the commit message should not be worded as if
> we're fixing some bug here.  And it should also not include the
> 'Fixes' tag as this change should go to net-next only and must
> not be backported.
>
> So, I'd suggest to re-word the subject line so it doesn't contain
> the word 'Fix', e.g.:
>   net: openvswitch: stricter validation for the userspace action
>
> And re-wording the commit message explaining why it is better
> to have strict validation without implying that this change is
> fixing some bugs.  This includes removing the 'Fixes' tag.

Thanks for the feedback Ilya! As I got no other reviews/feedback, I=E2=80=
=99ve sent a v2 addressing your feedback.

Cheers,

Eelco

>>  net/openvswitch/flow_netlink.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_net=
link.c
>> index 518be23e48ea..ad64bb9ab5e2 100644
>> --- a/net/openvswitch/flow_netlink.c
>> +++ b/net/openvswitch/flow_netlink.c
>> @@ -3049,7 +3049,8 @@ static int validate_userspace(const struct nlatt=
r *attr)
>>  	struct nlattr *a[OVS_USERSPACE_ATTR_MAX + 1];
>>  	int error;
>>
>> -	error =3D nla_parse_nested_deprecated(a, OVS_USERSPACE_ATTR_MAX, att=
r,
>> +	error =3D nla_parse_deprecated_strict(a, OVS_USERSPACE_ATTR_MAX,
>> +					    nla_data(attr), nla_len(attr),
>>  					    userspace_policy, NULL);
>>  	if (error)
>>  		return error;


