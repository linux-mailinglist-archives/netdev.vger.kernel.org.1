Return-Path: <netdev+bounces-212881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634D7B225CF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252A3504AD1
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125052EE5F0;
	Tue, 12 Aug 2025 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Su4C3LIr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9462E338D
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997679; cv=none; b=hYzn3tHoFlsaLrpemXpVpHs7YFcH65xgpWRjo1haDA/Mx4KeHsqa649uoiHZUoHbug7JmJMsbDCqF1y+xf9uMuJ+LlY+93g9yoLR0DITfRfj3sZIOC/49nYYO0s2ny+tNzyvpu+JGZfFxKgX11g4hVhUhx/JYecta62pC4k8miQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997679; c=relaxed/simple;
	bh=cTlXfAlpd7DMlTs9+mYdwxMDc//7WDK2efwXh7g3eOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5OpsUgVovO4lEpRPLjzBQfdHTwEBVBV673uTCVBMqhe2/tAbin7UEJYPRx0bbd4wgzRnhDgbxSeZmv2XLktWpuUsTGv+niKMsDBOZqhNXUztR47i6XIeveFi3PGRvtnwXwilMQFRxBWFQRCDQlc2fS4ubpmffHib0I+nO4O7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Su4C3LIr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754997676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WbAsnZe+CMSe25+BMPpOAE6rHeexr8oC2ol5n9/5+40=;
	b=Su4C3LIr3C7/5eqacLMN+rk+B97AwO6vXQ7UuRl9LfMTEifLe9ovG8b8R0dMnDEhz22FHq
	l9L5SIc8KbQdAo3qEwpDxHu5wynq+MyBUVphg2e00E1BBY9lhHmwWKTmR/OMKOjGgMQiQI
	etIIWYjzpO/QnGrOm5sKm+y3rHvPMQs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-aRINOPASOQSXVM-qyhIPqQ-1; Tue, 12 Aug 2025 07:21:15 -0400
X-MC-Unique: aRINOPASOQSXVM-qyhIPqQ-1
X-Mimecast-MFC-AGG-ID: aRINOPASOQSXVM-qyhIPqQ_1754997675
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b068c25f04so124903751cf.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997674; x=1755602474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbAsnZe+CMSe25+BMPpOAE6rHeexr8oC2ol5n9/5+40=;
        b=spJNw46xSaXGiVUKpXM8gJN+iX0Gxaj6ZrxRxw/8sh7i92YmJnuV1o5evnD2bCp+UO
         WWBPSrlLrsbT0o0tNW1HIGjjADBfUk4Xnu9a3CBHBsM2WFVhDxl9PkrNuPoC6zgRkydz
         zcWEAAwvFcxn0KZA14sO0Wipdms5uj83w/wZ3eX6wRRbcTTF7TisiuwtL+BqvzfT89t5
         UyyaFO3kDYf1fuqo8ieyuoWJpZigDu7SPbWni4bX3divU0gKKY7GEl2jOo96US/jHZcS
         rtEqCrhyTY/t62M7xAqcgBGnkVi3PnTQqmV1wGK4zNuAtiFeNa6Imj5wIQ4NcaAoPoV7
         P8qA==
X-Forwarded-Encrypted: i=1; AJvYcCXVQpgWBxY9OVU59B0YmAriYuGLwgaulOshMl3GchpMgl3OU27lI5TPs+fee7605DlSp22LGsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjPRMMYMckBwSCGWRRCNZIwNaJvT1MqZAWnQ0eyiwqaMrUhn31
	Mkd9G1lg+vqdzqYlHqu77KcV490Li3rjuvB6w/gyU/fi2g/B1i3IqpRi/SrUSX6urg10A1HPkE/
	OLUOPKscy9Hxqn4xsI0LLppTyBkd90FzKckF9fmPl3Ywfw4VLchR1n1Fbxw==
X-Gm-Gg: ASbGnctTE9K3f6WXnY1f819yeygOqCWcK88DCdnXOiQcEcXlXL3WZ1rAl5ukFKdVEne
	4Bd40BgKLDM+2QdsF/NV/qqGKtnJgkcjBgY8+6ZasHlktLr0QF2WR44B0PJH5AoDo86TNhpRZXX
	dhQmZjqSNW+ACNRoso/gb6OYGzdD9b4UplFT9VK0NUx4AL72IHzPSpiqK7oZbQ+JIs5A9Y6Jy9L
	SzwNL5I15LAq+swy4NdUe5Sn4TsT/g41UrYT2sVNVB05q+RuLIQbyax5AHD527y+fl7NB5qdCVm
	Vnat/J2GcyHVujKAZ1js3HD/nghFFKcgznNOBA==
X-Received: by 2002:ac8:58cf:0:b0:4b0:7db9:92d7 with SMTP id d75a77b69052e-4b0ee04e984mr35507241cf.2.1754997674530;
        Tue, 12 Aug 2025 04:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLmZAugXAnbTdLnXsRtm+/4DFD6AKXjeE0O/Aps+txIjK0Opbit7bLRuzqhunHyDppvhOBpA==
X-Received: by 2002:ac8:58cf:0:b0:4b0:7db9:92d7 with SMTP id d75a77b69052e-4b0ee04e984mr35506751cf.2.1754997674051;
        Tue, 12 Aug 2025 04:21:14 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b095e6c7d4sm88439961cf.54.2025.08.12.04.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:21:13 -0700 (PDT)
Date: Tue, 12 Aug 2025 13:21:11 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Lion Ackermann <nnamrec@gmail.com>,
	Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
	Ivan Vecera <ivecera@redhat.com>, Li Shuang <shuali@redhat.com>
Subject: Re: [PATCH net] net/sched: ets: use old 'nbands' while purging
 unused classes
Message-ID: <aJsjpyqVrEh6P26W@dcaratti.users.ipa.redhat.com>
References: <f3b9bacc73145f265c19ab80785933da5b7cbdec.1754581577.git.dcaratti@redhat.com>
 <8d76538b-678f-4a98-9308-d7209b5ebee9@mojatatu.com>
 <aJmge28EVB0jKOLF@dcaratti.users.ipa.redhat.com>
 <81bd4809-b268-42a2-af34-03087f7ff329@mojatatu.com>
 <c3ffa213-ba09-47ce-9b9b-5d8a4bac9d71@mojatatu.com>
 <aJoV1RPmh4UdNe3w@dcaratti.users.ipa.redhat.com>
 <2ac9d393-a87b-4b55-87d6-0b76542e63c9@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac9d393-a87b-4b55-87d6-0b76542e63c9@mojatatu.com>

On Mon, Aug 11, 2025 at 02:35:50PM -0300, Victor Nogueira wrote:
> On 8/11/25 13:09, Davide Caratti wrote:
> > On Mon, Aug 11, 2025 at 10:52:08AM -0300, Victor Nogueira wrote:
> > > On 8/11/25 06:53, Victor Nogueira wrote:
> > > > On 8/11/25 04:49, Davide Caratti wrote:

[...]
  
> > so, including "plug" children in the tree should make kselftest feasible either with 'net/forwarding'
> > or with TDC + scapy plugin superpowers.
> 
> I see, so I think it would be better to use the 'net/forwarding' approach
> with
> "plug" children mainly because it looks simpler.

AFAIS the problem with TDC scapy plugin is: it doesn't work well with nsPlugin.
At the moment it can only inject packets in $DEV0 transmit, assuming that $DEV1
will do something with received packets. So, some TC mirred trickery is needed to
test qdiscs (or alternatively, qdiscs with traffic should be tested in the main
namespace using $DEV0 - but this is not friendly to other tests)

(some mirred trickery be like: adding 1 tc-mirred line at the end of "setup")

    {
        "id": "1027",
        "name": "purge DWRR classes with non-empty backlog",
        "category": [
            "qdisc",
            "ets"
        ],
        "plugins": {
            "requires": [
                "nsPlugin",
                "scapyPlugin"
            ]
        },
        "setup": [
            "$TC qdisc add dev $DUMMY root handle 1: ets bands 4 strict 2 priomap 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3",
            "$TC qdisc add dev $DUMMY handle 10: parent 1:4 plug",
            "$TC qdisc add dev $DEV1 clsact",
            "$TC filter add dev $DEV1 ingress protocol ip matchall action mirred egress redirect dev $DUMMY"
        ],
        "scapy": [
            {
                "iface": "$DEV0",
                "count": 1,
                "packet": "Ether(type=0x800)/IP(src='10.10.10.1',dst='10.10.10.2')/UDP(sport=5000,dport=10)"
            }
        ],
        "cmdUnderTest": "true",
        "expExitCode": "0",
        "verifyCmd": "$TC qdisc change dev $DUMMY handle 1: ets bands 2 strict 0",
        "matchPattern": "match_pattern_not_relevant",
        "matchCount": "0",
        "teardown": []
    }


yes, net/forwarding should take less lines: will post a patch in the next hours. thanks,

-- 
davide


