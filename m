Return-Path: <netdev+bounces-146316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DF99D2C70
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE523B2AEC1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FFE1D1F46;
	Tue, 19 Nov 2024 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKM9Iji4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916ED1D173E
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036822; cv=none; b=QlEh7FD1ScpD9Hr0ReLDoYyPS17/1t5czwhIGmDpR0+bzr6o6/0GZPm0JhqV+XG2yaAa/FJp/dqd/xYl4LtWnKpJX2X/4aw0MgyOltWsh9SBmMRs8C1hyCCLEFUYBf+Pp1pAruRyZ3wwPTUkYPMK5hM02XxhQSopWWvui2OTt/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036822; c=relaxed/simple;
	bh=1PiG9NNQMJeY6K+RrrmYajQu8cAEeQJzhvtH3P3IZ/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Txht2swti7n7F9wTKXih9EXoRtFvxsgzHcH+YrYZFLzwljnVG8LqKP+WtbTziPfHHfKMzXm8B1mwKgLxQ8dasu9wSdeks+GvCUHOHRmZVUql65VPpkAvze7oiJ5EbRrczVYlrzNW0LLektEwcu/0Wy98NDSvmrThT93rlZoJg1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKM9Iji4; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83a9cd37a11so43367239f.3
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 09:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036818; x=1732641618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEtmknH6jBOs2M/FU6TYLuUeV4Uq2nbY08Ew6/G63oc=;
        b=CKM9Iji4EqgSQ3CHB7HdkKnry5JeacbcOg6wZDnbyr/Oy5LLwCnVRFwXioUqPTZD3F
         2we1rTiTvabEyuGXqsso9aeziy+yNPfSekDNWgFKqWQaJucUwqUHKCd33rujl5ve7xST
         MoBge5SJvTe+dAb335cr8vOtaV1xCFvgX+YWns5VMg/k6gcy+4QqPBW1Yw2dRCqQU5y0
         BqkwjsHv5zzShnuB/YjpzWnhdWgl2z60xakjZET5rHDSomm7aYcyL+3sfAF8qZ39Nqay
         s8uK02WovOtHwNDXOtXpf5/izER9n7wmbVVXco12AF1frs4/0APCRs0+ikNu2Ghf3SqZ
         npvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036818; x=1732641618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEtmknH6jBOs2M/FU6TYLuUeV4Uq2nbY08Ew6/G63oc=;
        b=e29SbLtkr0Trs9DppnRnpS0BIXJJgLNe9tN3ZsvqdiZM32CjcDRiCXEHefJ6OClGfp
         OXelpe+3MsP0tcROZMN4303bkDB0VWF7G1rKrVGnXXz8NFoOtNeMHVzHHE7RfqzaO4+l
         1XgxcSvu3IQGcSDf/MzrszPFuYQEGknHv1aR4mUC6UzeMU42ho7rKsjEiaNLajaFUNKr
         +Sb61Fi/PImfD8cQaQRt/4aRMUB3pjyGAf3CVjLtKA3YGTkxkRbl7FQCgl8cdvhQvvFW
         WAqkc2bTeJJBtbcG/wLIf+TpqF4d9aLMWv2BcwWq1i0SD+259VmUn6TTO+qi0hE/VebG
         HK1g==
X-Gm-Message-State: AOJu0YxwDj82Tf/ezhP3JMYgOcIKYqCiP1J9q/JU9bRG5q5dSy76+fjQ
	t54ugJpnSBIoBQX4rSWy7MVTKy+2FtpQ63eO0WqspNUA+sNU+vbZl2HO1imfgprLykQXB9NRVQU
	uKBWfaPW7gTRXMXzYsl2oJRVWWZQ=
X-Google-Smtp-Source: AGHT+IFNIU6k8F7ArLdllOif5oxK5fn3RcxneCvAOS8KIf6eHxb1iSvuyH2Ufjf7VMOjrqUylKMd1WrU5DVwl+8nLiw=
X-Received: by 2002:a05:6602:1614:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-83e6c315b31mr1918726539f.14.1732036818560; Tue, 19 Nov 2024
 09:20:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118145147.56236-1-annaemesenyiri@gmail.com>
 <20241118145147.56236-4-annaemesenyiri@gmail.com> <673ba52a4374f_1d652429476@willemb.c.googlers.com.notmuch>
In-Reply-To: <673ba52a4374f_1d652429476@willemb.c.googlers.com.notmuch>
From: Anna Nyiri <annaemesenyiri@gmail.com>
Date: Tue, 19 Nov 2024 18:20:05 +0100
Message-ID: <CAKm6_RtbJoysoteLH0Q6QQ4XH=wshSHgBeQ6DJRMos7-7G-xwg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] selftests: net: test SO_PRIORITY
 ancillary data with cmsg_sender
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, idosch@idosch.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the feedback, I will update the test.
Since the features are working well and the issues in the test are
cosmetic, could it be merged in its current state?
After the merge, I would submit the correction as a fix.

Willem de Bruijn <willemdebruijn.kernel@gmail.com> ezt =C3=ADrta (id=C5=91p=
ont:
2024. nov. 18., H, 21:35):
>
> Anna Emese Nyiri wrote:
> > Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> > ancillary data.
> >
> > cmsg_so_priority.sh script added to validate SO_PRIORITY behavior
> > by creating VLAN device with egress QoS mapping and testing packet
> > priorities using flower filters. Verify that packets with different
> > priorities are correctly matched and counted by filters for multiple
> > protocols and IP versions.
> >
> > Suggested-by: Ido Schimmel <idosch@idosch.org>
> > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > ---
> >  tools/testing/selftests/net/cmsg_sender.c     |  11 +-
> >  .../testing/selftests/net/cmsg_so_priority.sh | 147 ++++++++++++++++++
> >  2 files changed, 157 insertions(+), 1 deletion(-)
> >  create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh
> >
>
> > +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
> > @@ -0,0 +1,147 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +IP4=3D192.0.2.1/24
> > +TGT4=3D192.0.2.2/24
> > +TGT4_NO_MASK=3D192.0.2.2
>
> nit, avoid duplication:
>
> TGT4_NO_MASK=3D192.0.2.2
> TGT4=3D"${TGT4_NO_MASK}/24"
>
> etc.
>
> Or even drop the versions with the suffix and add that
> explicitly where used.
>
> > +TGT4_RAW=3D192.0.2.3/24
> > +TGT4_RAW_NO_MASK=3D192.0.2.3
> > +IP6=3D2001:db8::1/64
> > +TGT6=3D2001:db8::2/64
> > +TGT6_NO_MASK=3D2001:db8::2
> > +TGT6_RAW=3D2001:db8::3/64
> > +TGT6_RAW_NO_MASK=3D2001:db8::3
> > +PORT=3D1234
> > +DELAY=3D4000
> > +
> > +
> > +create_filter() {
> > +
> > +    local ns=3D$1
> > +    local dev=3D$2
> > +    local handle=3D$3
> > +    local vlan_prio=3D$4
> > +    local ip_type=3D$5
> > +    local proto=3D$6
> > +    local dst_ip=3D$7
> > +
> > +    local cmd=3D"tc -n $ns filter add dev $dev egress pref 1 handle $h=
andle \
> > +    proto 802.1q flower vlan_prio $vlan_prio vlan_ethtype $ip_type"
>
> nit: indentation on line break. Break inside string is ideally avoided to=
o.
>
> perhaps just avoid the string and below call
>
>     tc -n "$ns" filter add dev "$dev" \
>             egress pref 1 handle "$handle" proto 802.1q \
>             dst_ip "$dst_ip" "$ip_proto_opt"
>             flower vlan_prio "$vlan_prio" vlan_ethtype "$ip_type" \
>             action pass
> > +
> > +    if [[ "$proto" =3D=3D "u" ]]; then
> > +        ip_proto=3D"udp"
> > +    elif [[ "$ip_type" =3D=3D "ipv4" && "$proto" =3D=3D "i" ]]; then
> > +        ip_proto=3D"icmp"
> > +    elif [[ "$ip_type" =3D=3D "ipv6" && "$proto" =3D=3D "i" ]]; then
> > +        ip_proto=3D"icmpv6"
> > +    fi
> > +
> > +    if [[ "$proto" !=3D "r" ]]; then
> > +        cmd=3D"$cmd ip_proto $ip_proto"
> > +    fi
> > +
> > +    cmd=3D"$cmd dst_ip $dst_ip action pass"
> > +
> > +    eval $cmd
> > +}
> > +
> > +TOTAL_TESTS=3D0
> > +FAILED_TESTS=3D0
> > +
> > +check_result() {
> > +    ((TOTAL_TESTS++))
> > +    if [ "$1" -ne 0 ]; then
> > +        ((FAILED_TESTS++))
> > +    fi
> > +}
> > +
> > +cleanup() {
> > +    ip link del dummy1 2>/dev/null
>
> Both devices are in ns1.
>
> No need to clean up the devices explicitly. Just deleting the netns
> will remove them.
>
> > +    ip -n ns1 link del dummy1.10 2>/dev/null
> > +    ip netns del ns1 2>/dev/null
>
> > +}
> > +
> > +trap cleanup EXIT
> > +
> > +
> > +
> > +ip netns add ns1
> > +
> > +ip -n ns1 link set dev lo up
> > +ip -n ns1 link add name dummy1 up type dummy
> > +
> > +ip -n ns1 link add link dummy1 name dummy1.10 up type vlan id 10 \
> > +        egress-qos-map 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
> > +
> > +ip -n ns1 address add $IP4 dev dummy1.10
> > +ip -n ns1 address add $IP6 dev dummy1.10
> > +
> > +ip netns exec ns1 bash -c "
> > +sysctl -w net.ipv4.ping_group_range=3D'0 2147483647'
> > +exit"
>
> Same point on indentation on line continuation.
>
> No need for explicit exit.
>
> > +
> > +
> > +ip -n ns1 neigh add $TGT4_NO_MASK lladdr 00:11:22:33:44:55 nud permane=
nt dev \
> > +        dummy1.10
> > +ip -n ns1 neigh add $TGT6_NO_MASK lladdr 00:11:22:33:44:55 nud permane=
nt dev dummy1.10
> > +ip -n ns1 neigh add $TGT4_RAW_NO_MASK lladdr 00:11:22:33:44:66 nud per=
manent dev dummy1.10
> > +ip -n ns1 neigh add $TGT6_RAW_NO_MASK lladdr 00:11:22:33:44:66 nud per=
manent dev dummy1.10
> > +
> > +tc -n ns1 qdisc add dev dummy1 clsact
> > +
> > +FILTER_COUNTER=3D10
> > +
> > +for i in 4 6; do
> > +    for proto in u i r; do
> > +        echo "Test IPV$i, prot: $proto"
> > +        for priority in {0..7}; do
> > +            if [[ $i =3D=3D 4 && $proto =3D=3D "r" ]]; then
> > +                TGT=3D$TGT4_RAW_NO_MASK
> > +            elif [[ $i =3D=3D 6 && $proto =3D=3D "r" ]]; then
> > +                TGT=3D$TGT6_RAW_NO_MASK
> > +            elif [ $i =3D=3D 4 ]; then
> > +                TGT=3D$TGT4_NO_MASK
> > +            else
> > +                TGT=3D$TGT6_NO_MASK
> > +            fi
> > +
> > +            handle=3D"${FILTER_COUNTER}${priority}"
> > +
> > +            create_filter ns1 dummy1 $handle $priority ipv$i $proto $T=
GT
> > +
> > +            pkts=3D$(tc -n ns1 -j -s filter show dev dummy1 egress \
> > +                | jq ".[] | select(.options.handle =3D=3D ${handle}) |=
 \
>
> Can jq be assumed installed on all machines?
>
> > +                .options.actions[0].stats.packets")
> > +
> > +            if [[ $pkts =3D=3D 0 ]]; then
> > +                check_result 0
> > +            else
> > +                echo "prio $priority: expected 0, got $pkts"
> > +                check_result 1
> > +            fi
> > +
> > +            ip netns exec ns1 ./cmsg_sender -$i -Q $priority -d "${DEL=
AY}" -p $proto $TGT $PORT
> > +            ip netns exec ns1 ./cmsg_sender -$i -P $priority -d "${DEL=
AY}" -p $proto $TGT $PORT
> > +
> > +
> > +            pkts=3D$(tc -n ns1 -j -s filter show dev dummy1 egress \
> > +                | jq ".[] | select(.options.handle =3D=3D ${handle}) |=
 \
> > +                .options.actions[0].stats.packets")
> > +            if [[ $pkts =3D=3D 2 ]]; then
> > +                check_result 0
> > +            else
> > +                echo "prio $priority: expected 2, got $pkts"
> > +                check_result 1
>
> I'd test -Q and -p separately. A bit of extra code to repeat the pkts
> read. But worth it.
>
> > +            fi
> > +        done
> > +        FILTER_COUNTER=3D$((FILTER_COUNTER + 10))
> > +    done
> > +done
> > +
> > +if [ $FAILED_TESTS -ne 0 ]; then
> > +    echo "FAIL - $FAILED_TESTS/$TOTAL_TESTS tests failed"
> > +    exit 1
> > +else
> > +    echo "OK - All $TOTAL_TESTS tests passed"
> > +    exit 0
> > +fi
> > --
> > 2.43.0
> >
>
>

