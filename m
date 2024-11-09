Return-Path: <netdev+bounces-143550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D569C2F01
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 19:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79509282333
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03C019D886;
	Sat,  9 Nov 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+e7DHmJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93F198853;
	Sat,  9 Nov 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731175335; cv=none; b=aMkRGB9SvLHWjDDl2ELNAlg6jmHfYJjj+pcL+EDtqaEbYyJFSjAcjbFhU+VCBvmLs3xd7qB/JUAaixZmahg/AGTyfZ8n23tDMai7ocmf1kMfxpJHwFDL6QN3dw/X7CGepJq0P+YCzCaoPHBIpdqgJ6AVLzsPJnPblXvgEo89+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731175335; c=relaxed/simple;
	bh=FeLyUZvTBHbl1C0zFRijuNwt1QEAj5jW9xwfnTT3mrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptzqT5KfqQPHr/MjHhgdcCW3Rn9B6Jodznmq6OXDpJ68R4PEDPkI9sWRQOJ1K77dF7dsinbgupL+4QFNLD92AELEdgmh4sfYqoRzQzfldkLKy7c2HyxWeRWEOsETMzGkv/jZ1a2J9RFzFQaBdvZtyJUL+IHRvYhyugAc4THa8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+e7DHmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93906C4CECE;
	Sat,  9 Nov 2024 18:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731175335;
	bh=FeLyUZvTBHbl1C0zFRijuNwt1QEAj5jW9xwfnTT3mrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L+e7DHmJVYAyyofeNoxC4kZ1nc1jlh98WKQNrZjUcek3tRXXxhUHg8u+fc25bFKgS
	 CnYVXaDnQqx/3eryPpAXVgBbRurdQ1qYFHxsCoucB1ep0tEtW6IFDU3yWUpjaO4vDS
	 XNadluKG342KLWiGr1MCNWSLHoo0BddV5TCN/W01tbWW4+X9eMs07jvHJbtakLaoRj
	 38AqB3uEq5ht8gtQkX4lvg6PtJUY9cDUj8hRPzncLl5xDKQ0VZyDMzcqbmMSTMWVXA
	 +uvdPuTnU4pEquXJyLvxab20pUhT0Ja0VL+A5ilmZvsKWMDmtLzRhN+I+VaEPxm9SA
	 LQnF6vzDmq2RA==
Date: Sat, 9 Nov 2024 10:02:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Potnuri
 Bharat Teja <bharat@chelsio.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Manish Chopra <manishc@marvell.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 1/2][next] UAPI: ethtool: Use __struct_group() in
 struct ethtool_link_settings
Message-ID: <20241109100213.262a2fa0@kernel.org>
In-Reply-To: <9e9fb0bd72e5ba1e916acbb4995b1e358b86a689.1730238285.git.gustavoars@kernel.org>
References: <cover.1730238285.git.gustavoars@kernel.org>
	<9e9fb0bd72e5ba1e916acbb4995b1e358b86a689.1730238285.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Oct 2024 15:55:35 -0600 Gustavo A. R. Silva wrote:
> Use the `__struct_group()` helper to create a new tagged
> `struct ethtool_link_settings_hdr`. This structure groups together
> all the members of the flexible `struct ethtool_link_settings`
> except the flexible array. As a result, the array is effectively
> separated from the rest of the members without modifying the memory
> layout of the flexible structure.
>=20
> This new tagged struct will be used to fix problematic declarations
> of middle-flex-arrays in composite structs[1].

Possibly a very noob question, but I'm updating a C++ library with=20
new headers and I think this makes it no longer compile.

$ cat > /tmp/t.cpp<<EOF
extern "C" {
#include "include/uapi/linux/ethtool.h"
}
int func() { return 0; }
EOF

$ g++ /tmp/t.cpp -I../linux -o /dev/null -c -W -Wall -O2
In file included from /usr/include/linux/posix_types.h:5,
                 from /usr/include/linux/types.h:9,
                 from ../linux/include/uapi/linux/ethtool.h:18,
                 from /tmp/t.cpp:2:
../linux/include/uapi/linux/ethtool.h:2515:24: error: =E2=80=98struct ethto=
ol_link_settings::<unnamed union>::ethtool_link_settings_hdr=E2=80=99 inval=
id; an anonymous union may only have public non-static data members [-fperm=
issive]
 2515 |         __struct_group(ethtool_link_settings_hdr, hdr, /* no attrs =
*/,
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~


I don't know much about C++, tho, so quite possibly missing something
obvious.

