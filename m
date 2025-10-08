Return-Path: <netdev+bounces-228224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56522BC51DE
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 15:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4867340652C
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 13:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048F725EFB6;
	Wed,  8 Oct 2025 13:03:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1E26D4C3
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928583; cv=none; b=TTEi5VWa47RhaYIiGF04wmgxZqykZXY84UXfY4H+J+FchXvT17By9jRyawuc5XdD+akMWNvSZMSITcm+iRqnf+r4OY/r67XWQDQMNk9aEa4UYo8MPrHUUJGADa8ssd+OOZOX+mhdqKH/x3Zmm6dpvsYGVJtcZ/XeFMS+Sm4NnAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928583; c=relaxed/simple;
	bh=EIAWGhW8A2v+ZxqAjP2xba0nfScSMoScw5np+T9vffE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON1DEfyGblhnaNU4l5KoWIMZwbYjg2XTA3aOyXzC7HKy1UWqzMu9Kd2FfMMKCJUIK8AkR/uPs/hOMG62wOEeMFVuZSO/nrx0wet1rMWMwe+HlXN58AR5x0pA+IBYOVS13G4X2Matv3xg/VBLMqI6rtlTil8/ld6H/iV27+XTn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b50206773adso175169566b.0
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 06:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759928580; x=1760533380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddtNPUJibRxzuhh3dSgUV8Un+ayK9jnQFI5eAYadmU0=;
        b=l7Np8I1XwFQ5euVgcCYYt0woGaeooBf/EmDT82hMXTA34AHlkrSRR0NNDSXAGasctQ
         GTihFodgQsvzaA63CdtoDQ1Qd9LIuciPPqgsjNcsHmWfqzQBGo8YKL9/t0Ui6XXvAdeN
         30SnXYVRD3xTUWL5JREWEJrsORwVT+84lJZDilaSLUQOHI7CUMWq0fqOuhyTwQIVFRmt
         JOdtRzrXJC5g/FGn5t0LfCY3jFYGWLCWlzWbWfpXidJE0l4i0/3vjORIW8gQ3boAkd4L
         Z1B/wsc1wxKiNVe6hPx2PsmBDp3mGvl0CGvZXr844TOzmX271FuPhvqMXOoiud122TKt
         HWWg==
X-Forwarded-Encrypted: i=1; AJvYcCWIAnz0gcfwhbfJ4b4qOynuusp6bsJ3OB/Hl/kp2QR96pRA3YQIkTDjzwe/Y8uyytNYsnYUKTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCGa8SU7jzLq/MdqReXDM6co9S9ayVNwSbIocQ9r9xUsBN7mxy
	1FzDBnhBCDzHpow1YW78RDEvp1bRhZldwQk4YlDFtNLJbSKroKh65mZIDQXOGg==
X-Gm-Gg: ASbGnct0PTlXyoauGxUG3+BZ9rwpzLvoUrVWRku4HZs/Aa+egofFy8FDUL/xzHRLzxm
	6vnXoGv/KMc5xB/J8CbI7eb7EU8vHHbqKokPtnH//pqaR8WasSG6Nn0wCsVNVbDKoZLHLMEI+b/
	BBazZXpUP9Jey4U5A1SctjSYjQE3reHQsQ/WuFHKr/FUDRIhMoEnmS8MIW8feKNyQCh6kWlg3id
	MLSg0uH6ft56aPcgqZVTVUQt6XGFQIN95nAXZsy+orZnqLLM0IhUhjFn5LK+E5736zM30f2YDA+
	EVMGxn5071ScErH3eUHvWy9q5CF6WwbDm4sZbCOc9USua00ioBU1201ZvSZqno0xTpJP/AaZdx4
	hev9YwmJuJcf0y4iCp3XuCfm5niSzFPWOBkRIubJSaA==
X-Google-Smtp-Source: AGHT+IFCsOv+E+hkE/ODWPwUMsik0P5C7r77C29nZTRyMVSRUaIvoxt5GdpsOgvdOE/VgE3kaUEYsQ==
X-Received: by 2002:a17:906:6a1f:b0:b04:3cd2:265b with SMTP id a640c23a62f3a-b50bcc09d8dmr365835566b.5.1759928579841;
        Wed, 08 Oct 2025 06:02:59 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a60dsm1631679466b.63.2025.10.08.06.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:02:59 -0700 (PDT)
Date: Wed, 8 Oct 2025 06:02:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v7 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <m2dwihyj3vddvipam555ewxej663brejyv5gdnsw4ks5mis2y7@2mu2gus2o7ys>
References: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
 <20251003-netconsole_torture-v7-4-aa92fcce62a9@debian.org>
 <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>

Hello Paolo,

On Tue, Oct 07, 2025 at 11:47:22AM +0200, Paolo Abeni wrote:
> On 10/3/25 1:57 PM, Breno Leitao wrote:

> > +# Test #5: Enslave a sub-interface to a bonding interface
> > +# Enslave an interface to a bond interface that has netpoll attached
> > +# At this stage, BOND_TX_MAIN_IF is created and BOND_TX1_SLAVE_IF is part of
> > +# it. Netconsole is currently disabled
> > +enslave_iface_to_bond
> > +echo "test #5: Enslaving an interface to bond+netpoll. Test passed." >&2
> 
> I think this is missing the negative/fail to add test case asked by
> Jakub. AFAICS you should be able to trigger such case trying to add a
> veth device to the netpoll enabled bond (since the latter carries the
> IFF_DISABLE_NETPOLL priv_flag).

Thanks for the review. I misunderstood what Jakub said, sorry about it.

I've tried to enslave a veth interface manually into a bonding
interface, and I can see:

	# ip link set veth0 master bond_tx_78
	 aborting
	 RTNETLINK answers: Device or resource busy
	
and dmesg shows:

	netpoll: (null): veth0 doesn't support polling,

If that is the test case that is missing, I will add it as an additional
test in the selftest, and send a new version.

> > +function create_ifaces_bond() {
> > +	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_NEW"
> > +	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_NEW"
> > +	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_NEW"
> > +	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_NEW"
> > +	udevadm settle 2> /dev/null || true
> > +
> > +	local BOND_TX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_1"
> > +	local BOND_TX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_TX_2"
> > +	local BOND_RX1=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_1"
> > +	local BOND_RX2=/sys/bus/netdevsim/devices/netdevsim"$NSIM_BOND_RX_2"
> 
> Note that with the create_netdevsim() helper from
> tools/testing/selftests/net/lib.sh you could create the netdevsim device
> directly in the target namespace and avoid some duplicate code.

Awesome. I am more than happy to create_netdevsim() in this selftest,
and move the others to use it as well.

> It would be probably safer to create both rx and tx devices in child
> namespaces.

Sure, that is doable, but, I need to change a few common helpers, to
start netconsole from inside the "tx namespace" instead of the default
namespace.

Given all the other netconsole selftest uses TX from the default net
namespace, I would like to move them at all the same time.

Do you think it is Ok to have this test using TX interfaces from the
main net namespace (as is now), and then I submit a follow patch to
migrate all the netcons tests (including this one) to use a TX
namespace? Then I can change the helpers at the same time, simplifying
the code review.

> > +	# now create the RX bonding iface
> > +	ip netns exec "${NAMESPACE}" \
> > +		ip link add "${BOND_RX_MAIN_IF}" type bond mode balance-rr
> 
> Minor nit:
> 
> 	ip -n "${NAMESPACE}" link ...
> 
> will yield the same result with a little less wording.

Ack. I will update. Thanks

> > +# Clean up netdevsim ifaces created for bonding test
> > +function cleanup_bond_nsim() {
> > +	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_DEL"
> > +	cleanup_all_ns
> 
> If all devices are created in child netns, you will not need explicit
> per device cleanup.

Ack!

Thanks for the review,
--breno

