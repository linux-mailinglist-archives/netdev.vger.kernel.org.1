Return-Path: <netdev+bounces-243243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD4C9C2E7
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C993A4DEB
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15514274B4D;
	Tue,  2 Dec 2025 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="YdPyiOF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B2263F52
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692528; cv=none; b=MOCSMaht84X26Q1sIKfJgq1rZDh4WmTZPftSumSfryAfnNfV+eQHc/dxWdfPy/XQSvzK2J/VFe0V5LN1V7EIvSW/flpF4MMbRSvX8g3vPD5rX9jfdOBzE+zEQ3YICBYybN8bSJU869xJvRi0wa48rsfgr+aHwMEECXj4f5xj5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692528; c=relaxed/simple;
	bh=4eFgu4Wc8Iiyh9Ps3XVPYbBe5+VNG2eqpZjMdGQ2f88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2tfQKdwfNR5LaOcooH1sSQXcHcDnL4jKIZdABNBns1tHMkiktJeqbWxtU8rEGxeTW1a9TLIqFEbjTEYAuRz4EK0PAjsVjN97Jw6ZJi0wdbvEds+5oe7Ci/ksArq0X2Sy3CEcRwo9HlBERwk3yap91SIYCpzvf7BxwUhelDG0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=YdPyiOF3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so59274475e9.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 08:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1764692524; x=1765297324; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YBPyIQuGcgY4t5uQjDubY4g3StfM0Xepo893vMnctdw=;
        b=YdPyiOF3/TH7CG0Eo5f3yOf8inG9rqyZAuK4zhA4/S2A8r8rcjNbo6HobO/q/+YEok
         d0YAuq/tOQ9Gaeu7VqTBaH7f/fmv+plIJ/luvs84f49ksbs+WFe7Z8bqi9bHhR0Q2DJq
         sMB92+uUkIe98BLMbXkHQtXi5S4gZ9Q8D/QSxoHmXDiLIe7dix5aG3YRyvd77VYGsmDv
         ReYa1PbYi/mK+pbSIQhLQqvR4+JYRG4H7jAThbAxhVWicQRBR5kPkE1B4pd+60zC3/CQ
         76Qm/OfpIqrrrJUksMJwh89QHwBVgg7VooYk3/vPj4QZBOMXajHsRRhqaMcvModOMOj9
         OItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764692524; x=1765297324;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBPyIQuGcgY4t5uQjDubY4g3StfM0Xepo893vMnctdw=;
        b=uTVdnqWwGSjmINuYObXxJZ2uIHLzme9relGeGh0F1YPfGYIHmdlC278LHHtNdLhCoS
         8U/WYmA3wn6Q4Dlvq9BZrO0iL/bG0PsGc3ML4JFIMxYFY+LnRREhvCpLZsvasKD0F6rN
         CsiOalNl8HvAJHmJmD6CZn+jwcLlGdhIYyGIac+FXWwIGnhin70O9aNGKkT0HiIJEXy8
         nVE+JkBn9WjyumsAvFV+WmsbY6md1chVu1lzhegQv5+HqyCH0NSHzrT7o9T5Xkmavg5P
         xWDsg987cplkjjZ4q2csYhJaiRyYYCYVs8KoqZlWagXKyfBqqgzHIhUg1h0J2AAMQI5n
         /JwQ==
X-Gm-Message-State: AOJu0Yz0mzEbCFPlKZ+jtU/d7TaFfGzNTOPc+HwYUwK7XX78ImMcehb4
	duLv6eNgEtj+IhMZH866cRPLFjQTflzEUZ+WIuFim8EgATFmYXo7VG2R4yrEs14b79Q=
X-Gm-Gg: ASbGncsCdjb9fiIphOSNy9/QPTHL9c/Q1kp9ow+YqcMvq2g7aq3cFan/IYNgrO1Ed0a
	6662Ph301/61VtE8BsHnUfITKy3oyleSWUml1KbgHhqPQnFv2HUYz40Sr/ps7Do5hBMDeo/CNLh
	2XmsGLvQfISg4nQdPlD/KIh2hrfIz5sNOWW4nEfV33E6sOPMHxSSOTdyg9SpXPBKHt8/KKWEjeh
	AfXm/a/pxvx9zYdBRIj3O2NlX3fXnkRm9XfZgazyBlLBB83rT6NMLF685M8dJQLlDs9Tu7zU995
	Tvp3rsl3Ll9d98+WDVmGo7AS7qTGNTLfAICY1INtK/x6J2lrM6zfq11bDvAustZ5znszRiFSgGB
	cXBF367KRQ7XqQeZu7SLDhIn12nQ6KVO/8THmcPwjB+0Qr9E4IjBCKl7tJAmRHjOOtevkrWWnhv
	/U2STYEGT3eVV3yidcbXm1CqrPZtJXqvmVnSBOcLs3Oph1mv6FaSDKx+Fkg7hzPoHzhxeq
X-Google-Smtp-Source: AGHT+IEWsns29LrHk/RldRk33gVcFfrNfkJfvAWPKFxQmoN+SyF+9rzUpcf4mTjAICvMSR7OyVF8wA==
X-Received: by 2002:a05:600c:1c1a:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-4792a4961eemr2115565e9.13.1764692524255;
        Tue, 02 Dec 2025 08:22:04 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a61c5e1sm236225e9.1.2025.12.02.08.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 08:22:03 -0800 (PST)
Message-ID: <217d870daf5d9880fa37116161dc3e7c49947060.camel@mandelbit.com>
Subject: Re: [RFC net-next 08/13] selftests: ovpn: add test for the FW mark
 feature
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Antonio Quartulli
	 <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Date: Tue, 02 Dec 2025 17:22:03 +0100
In-Reply-To: <aSgxZ0Z6eDWS0vva@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
	 <20251121002044.16071-9-antonio@openvpn.net> <aSgxZ0Z6eDWS0vva@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-27 at 12:09 +0100, Sabrina Dubroca wrote:
> 2025-11-21, 01:20:39 +0100, Antonio Quartulli wrote:
> > diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c
> > b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> > index baabb4c9120e..4df596d29b8c 100644
> > --- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
> > +++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> > @@ -1693,12 +1705,13 @@ static void usage(const char *cmd)
> > =C2=A0	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
> > =C2=A0
> > =C2=A0	fprintf(stderr,
> > -		"* new_multi_peer <iface> <lport> <peers_file>: add
> > multiple peers as listed in the file\n");
> > +		"* new_multi_peer <iface> <lport> <peers_file>
> > [mark]: add multiple peers as listed in the file\n");
> > =C2=A0	fprintf(stderr, "\tiface: ovpn interface name\n");
> > =C2=A0	fprintf(stderr, "\tlport: local UDP port to bind to\n");
> > =C2=A0	fprintf(stderr,
> > =C2=A0		"\tpeers_file: text file containing one peer per
> > line. Line format:\n");
> > -	fprintf(stderr, "\t\t<peer_id> <tx_id> <raddr> <rport>
> > <laddr> <lport> <vpnaddr>\n");
> > +	fprintf(stderr, "\t\t<peer_id> <tx_id> <raddr> <rport>
> > <laddr> <lport> <vpnaddr> [mark]\n");
>=20
> This line should be dropped, this patch doesn't have the corresponding
> change to parse mark while we're looping over the lines of peers_file.

Right, the usage() strings can sometimes be a bit hard to visually
parse.

>=20
> > diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh
> > b/tools/testing/selftests/net/ovpn/test-mark.sh
> > new file mode 100755
> > index 000000000000..a4bfe938118d
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/ovpn/test-mark.sh
> [...]
> > +for p in $(seq 1 3); do
> > +	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
> > +	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} $((${p}
> > + 9)) 60 120
> > +done
> > +
> > +sleep 1
> > +
> > +for p in $(seq 1 3); do
> > +	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3
> > 5.5.5.$((${p} + 1))
>=20
> Any reason this ping (and the final one) uses -s 3000 while the one we
> expect to fail doesn't?

No, I think it's a copy-paste leftover. I'll drop this option since it
doesn=E2=80=99t add much value to the test.

>=20
> > +done
> > +
> > +echo "Adding an nftables drop rule based on mark value ${MARK}"
> > +ip netns exec peer0 nft flush ruleset
> > +ip netns exec peer0 nft 'add table inet filter'
> > +ip netns exec peer0 nft 'add chain inet filter output { type filter
> > hook output priority 0; policy accept; }'
> > +ip netns exec peer0 nft add rule inet filter output meta mark =3D=3D
> > ${MARK} counter drop
> > +
> > +DROP_COUNTER=3D$(ip netns exec peer0 nft list chain inet filter
> > output | sed -n 's/.*packets \([0-9]*\).*/\1/p')
> > +sleep 1
> > +
> > +# ping should fail
> > +for p in $(seq 1 3); do
> > +	PING_OUTPUT=3D$(ip netns exec peer0 ping -qfc 500 -w 1
> > 5.5.5.$((p+1)) 2>&1) && exit 1
>=20
> nit: inconsistent syntax for p+1 compared to the other pings ($((p+1))
> vs $((${p} + 1)))

Ok, I'll keep a consistent style for pre-existing files and follow
shellcheck's suggestions for new ones. Later we can then cleanup the
existing shellcheck warning on the older files.

>=20
> > +	echo "${PING_OUTPUT}"
> > +	LOST_PACKETS=3D$(echo "$PING_OUTPUT" | grep 'packets
> > transmitted' | awk '{ print $1 }')
> > +	# increment the drop counter by the amount of lost packets
> > +	DROP_COUNTER=3D$(($DROP_COUNTER+$LOST_PACKETS))
> > +done
> > +
> > +# check if the final nft counter matches our counter
> > +TOTAL_COUNT=3D$(ip netns exec peer0 nft list chain inet filter output
> > | sed -n 's/.*packets \([0-9]*\).*/\1/p')
> > +[ ${DROP_COUNTER} -eq ${TOTAL_COUNT} ] || exit 1
>=20
> Maybe add something like
> =C2=A0=C2=A0=C2=A0 echo "Expected ${TOTAL_COUNT} drops, got ${DROP_COUNTE=
R}"
> if we're failing at this stage?

ACK.

> > +
> > +echo "Removing the drop rule"
> > +ip netns exec peer0 nft flush ruleset
> > +sleep 1
> > +
> > +for p in $(seq 1 3); do
> > +	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3
> > 5.5.5.$((${p} + 1))
> > +done
> > +
> > +cleanup
> > +
> > +modprobe -r ovpn || true

--=20
Ralf Lici
Mandelbit Srl

