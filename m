Return-Path: <netdev+bounces-73370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED09F85C2D6
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 18:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5971C2206C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298AD78696;
	Tue, 20 Feb 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsL3rmAD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5076C6C
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450715; cv=none; b=MB/kT8nCvNkoN4YA9bSefQScl83WXaVzS5m73owoDyXinUM2U4wO4bKOYJEkll8LcSscwfQ9VNQqhWEQzdY6Wyo39M3dlL3LVBgAYcV4oTV2MdH9UeM01D8EiEBS1hBTAJL58x736KRxONEK2Xs4kOGkBKXpfZaLs5v+rg8Fp8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450715; c=relaxed/simple;
	bh=sWPQxpJ5JhFTeEb001dgjhbqbJO6mGNTN4LhH7v9mso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJuVylwkm9ipKFEy0jZzLSmwf55FrJQ23gbCCr0yItMDcSfJphA9pyRLv6tzxAXKWCvHq9RyKgHDlp3RXu1mcbx+jYV6cbAbVPRKGqErUCDQYg9gEH9uM/ydpVAAOTc02AhgZH9+i9v3U/9qQI8LBZePdWUOfbfn6xII3lJ/jfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsL3rmAD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708450712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qn55PbDxlcyDzSN0idKbH2F2di32wdsURfOsZLp+bU0=;
	b=PsL3rmADH4ox1CFYT3kWbvu82ORETJ9EFIdyIFRqgoqjxg4/cNlbgjaYVhGqXckIhUlBKm
	eZSsv0yOZhuGft1Lb9W7UmLuooAxs8yoWKkRwp7y5lOid6ddMPZ/0ALMSJIsOOlWeEcvda
	75ttire8SpycHx+nqg0ZofrL7aZcv1E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-ACDUv6p6N6antvZJ5IDnMQ-1; Tue, 20 Feb 2024 12:38:30 -0500
X-MC-Unique: ACDUv6p6N6antvZJ5IDnMQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6800aa45af1so78043656d6.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 09:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450709; x=1709055509;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qn55PbDxlcyDzSN0idKbH2F2di32wdsURfOsZLp+bU0=;
        b=Mjgj2cpV79wZn/gdaRJ3j67Kkf/NF73Yl8Ipqyqlwj8vYNzUL74/so6TPqIboHYxzF
         JqiIUyzFuduJGuVSVcBs7IM/97LQXNmWdUpgcZHIoNWeqDSErMuBGRbFHAy2GIZE3HBZ
         JhUxmacegYArsFi24/C0r9QxW/x8nieLr0LnfaJX/pIviMonNPxpv6HFl0I+VNuY6mr/
         G2XRbc/TYqxzq46+xUEjlS6e07UbuGwEc4gmEhsuPaAiOUJ1Fl5j/TUsu/xQ14q3jQ8g
         jPk6hwLUQUOX1CyGCxkpgkuNpMyvkDIEMr0QkFFyYf+f/HqWzgQTsZrfWiYJ3S5q6RxO
         4sJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKh5r4DNN6ZjE1qC+EMdLoZK5IDNM9V+B9+B2LjyDsFRoFuXZ+7qYob/naBa4Ve0uu4GWIq44UAE+KTiybxAhXb3N+leZQ
X-Gm-Message-State: AOJu0YzS1SktAiRqC5zSP2YBj4dSmzqfZ6peQOYSh2lMjA/rkO+Npa0B
	/7nd2OACLgwV/3WsG1VfMsVqI0m9XPUKrB8t2bGZKzf0cZI6xWjtPZBrhLfVrwZQjUvKNYy5tle
	8HPbxQ0uEyk2fHoDxzawCPibmdT9n2SJc1L9hJMhJTA0OPZkVcY8oHrrZQ0m0Zg==
X-Received: by 2002:a05:6214:e61:b0:68f:6260:f723 with SMTP id jz1-20020a0562140e6100b0068f6260f723mr7978326qvb.49.1708450709585;
        Tue, 20 Feb 2024 09:38:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPEiisDHYagQqfgdyTO0C+ZU+atUpAKG/0i+pMgPq3cIPMfW9JW9MVlTXN5kfFRL0jV660rA==
X-Received: by 2002:a05:6214:e61:b0:68f:6260:f723 with SMTP id jz1-20020a0562140e6100b0068f6260f723mr7978308qvb.49.1708450709254;
        Tue, 20 Feb 2024 09:38:29 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id nc9-20020a0562142dc900b0068f58a8e09csm3498212qvb.108.2024.02.20.09.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:38:28 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bigeasy@linutronix.de, davem@davemloft.net, dccp@vger.kernel.org,
 dsahern@kernel.org, edumazet@google.com, juri.lelli@redhat.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org, mleitner@redhat.com,
 netdev@vger.kernel.org, pabeni@redhat.com, tglozar@redhat.com,
 tglx@linutronix.de, kuniyu@amazon.com
Subject: Re: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <20240219185537.13666-1-kuniyu@amazon.com>
References: <20240219095729.2339914-2-vschneid@redhat.com>
 <20240219185537.13666-1-kuniyu@amazon.com>
Date: Tue, 20 Feb 2024 18:38:25 +0100
Message-ID: <xhsmhmsrvf33i.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/02/24 10:55, Kuniyuki Iwashima wrote:
> From: Valentin Schneider <vschneid@redhat.com>
>> @@ -53,16 +53,14 @@ void dccp_time_wait(struct sock *sk, int state, int timeo)
>>  		if (state == DCCP_TIME_WAIT)
>>  			timeo = DCCP_TIMEWAIT_LEN;
>>  
>> -		/* tw_timer is pinned, so we need to make sure BH are disabled
>> -		 * in following section, otherwise timer handler could run before
>> -		 * we complete the initialization.
>> -		 */
>> -		local_bh_disable();
>> -		inet_twsk_schedule(tw, timeo);
>> -		/* Linkage updates.
>> -		 * Note that access to tw after this point is illegal.
>> -		 */
>> +	       local_bh_disable();
>
> This line seems not correctly indented, same for TCP change.
>
>
>
>> +
>> +		// Linkage updates
>>  		inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
>> +		inet_twsk_schedule(tw, timeo);
>> +		// Access to tw after this point is illegal.
>
> Also please use /**/ style for these comments, same for TCP too.
>

Will do, thanks!


