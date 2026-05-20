Return-Path: <netdev+bounces-289956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ALpMNbDDWql3AUAu9opvQ
	(envelope-from <netdev+bounces-289956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:23:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3980E58F811
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B587300FB62
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909D93E6DD3;
	Wed, 20 May 2026 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="kcQ+ze50"
X-Original-To: netdev@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BAF3E63B8
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285893; cv=none; b=j1cMc31oHe2I8V/zoSr0LdXjFIu9LwB1JlGiOSJAueHwTQJW/DujMQXGN1wsdED3EE1FOeSLWNnRlP/D68tE+CXJqgWWmSgp9DaLzdb94TVAmRLB3IMhpb/9LGIiBXbiBmwalEBp+CHjCwPIaKGL8g7AtBLMJSfo0ZU34OJz8gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285893; c=relaxed/simple;
	bh=DJgzBrxWzv+5/4/gwuTKhOFW5Eta58h8tbb9c0pRLOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiyEV866h2OqU1xuH6kS7WJNQpMSvKmbz9N0kGTmtzd2RlfGed/6Qzriby3EZdWp7vNwnIlRuXZNI2eBLmpPdSapP3lG6HudcsAjjvEne1cOJqHs2XxzxRp4oWdeNKEuwjjIvyMsDnZngiER4P3LAjc8GjLP1g+a+IeSVZepndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=kcQ+ze50; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=3691; t=1779285856;
	x=1779890656; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Autocrypt:Organization:
	Disposition-Notification-To:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; z=Received:=20from=20[IPV6=3A2603=3A7
	002=3A100=3A8400=3Afc83=3A8701=3Ab9e7=3Aaab8]=20by=20auristor.co
	m=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=
	20PRO=20v26.0.2)=20=0D=0A=09with=20ESMTPSA=20id=20md500100529300
	1.msg=3B=20Wed,=2020=20May=202026=2010=3A04=3A15=20-0400|Message
	-ID:=20<e777cd2b-82be-46c3-8ebf-bddf502b450d@auristor.com>|Date:
	=20Wed,=2020=20May=202026=2010=3A04=3A47=20-0400|MIME-Version:=2
	01.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20[PAT
	CH=20net=20v4=200/3]=20rxrpc=3A=20Better=20fix=20for=20DATA/RESP
	ONSE=20decrypt=20vs=0D=0A=20splice()|To:=20David=20Howells=20<dh
	owells@redhat.com>,=20netdev@vger.kernel.org|Cc:=20Hyunwoo=20Kim
	=20<imv4bel@gmail.com>,=20Marc=20Dionne=20<marc.dionne@auristor.
	com>,=0D=0A=20Jakub=20Kicinski=20<kuba@kernel.org>,=20"David=20S
	.=20Miller"=20<davem@davemloft.net>,=0D=0A=20Eric=20Dumazet=20<e
	dumazet@google.com>,=20Paolo=20Abeni=20<pabeni@redhat.com>,=0D=0
	A=20Simon=20Horman=20<horms@kernel.org>,=20linux-afs@lists.infra
	dead.org,=0D=0A=20linux-kernel@vger.kernel.org|References:=20<20
	260515230516.2718212-1-dhowells@redhat.com>|Content-Language:=20
	en-US|From:=20Jeffrey=20E=20Altman=20<jaltman@auristor.com>|Auto
	crypt:=20addr=3Djaltman@auristor.com=3B=20keydata=3D=0D=0A=20xsF
	NBEwLlO0BEACu6yWFkd1+qwsGg8ZzgslSkcAKhSegWt5j86DpaRL0W8fxg6YjxwE
	PvwoH=0D=0A=20BGa/rpSdBd1gkmzeYxD3hVZdj75r6nVS9f/mxNQzW+o1sW4vae
	SxKgZSQz5RqHmwPDcqQP66=0D=0A=20+ZSnjV+G88MKwZ9DIzA9AwpJhNAAlAlj3
	OvsQVsxd1ipc6C4/U3qjHL7Ih22UbPBM71ltIZx=0D=0A=20kqcrAlXPnUTeraJX
	tfzYbq4mJFJ9JC6/o1NRSjsBvRD+ADxlG50+KccZN4SS5xxdGuh1tA9U=0D=0A=2
	0TydYBQB3YtJbq7CYau2kIYt/3HnyLYGo1s6Ti6cuAJJ/40iIE1xkqhvMiIz/Q+1
	ztmksJbLQ=0D=0A=20aCtW8kF42nF8MpPdIPTSPr2uGvpRtCjRbh4lgMXgyNUx1w
	pCEY0X11xce++H8HySmFwryE2y=0D=0A=20kkxUQeMUjaaXZDHYUSyQz7riChFiZ
	9ax9dmX0wUY/A05v0qcualglpk4wJ2kcsGKUEGkLvnV=0D=0A=20wwvya8zifPwK
	Ow5JlGPvzX8t2m7jB2GXKzvVAsImqOqnDBTKUXWQQZCW9Rqt7acdE8bQ2vqr=0D=
	0A=20vP+3Ykf4SrPwcuNCDt6QSgjVbhc3hA3hCtE1iW/HhuBAzKiuzJ9era+q9Qj
	TtLPIkQDHRpcC=0D=0A=20MMWvK0Y1uQ34Ql1BfKRA4gc8A7CuVUY6+Ga7PuJWd+
	FSglvmKQARAQABzTZKZWZmcmV5IEFs=0D=0A=20dG1hbiAoQXVyaVN0b3IsIEluY
	y4pIDxqYWx0bWFuQGF1cmlzdG9yLmNvbT7CwXkEEwECACMF=0D=0A=20AlY2YwgC
	GyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRD3enNVkraaBDdzD/0XQUDW
	=0D=0A=20UWXrpapHdvZaHzPHc3xobRi4PABWfLW1jfMK5Xy4DP/x7x3I2qAqTD6
	vv/OPFMx8gG6+Xeod=0D=0A=20Mj5vE7+7ZRd+J76J4DJH2qoaXX8qnUEABUJHZY
	Dhw2/Ij5AQ6ZsuSwXuURGEMi0vu1ihBbP6=0D=0A=203bt4LRIa+F60ebDvCl9po
	+UB7TrjQCs+YV1r1YeCSv9hEHBly/W0u1OrnNCMWRcq7dmTCbZ0=0D=0A=20R5w6
	VJ/+QEio+T6paGGMjJmrNw2qUeuK+SxOOxOWS8lgdqzjcK3NsfiERrVbOWM83ZVy
	0/GN=0D=0A=20vpusjhI/3Q8lbV/p+IsJk/v1grkRzgU0frES2ANEPTpC4j2ggPO
	SMpsz3BZ8wIOg17rIWnK+=0D=0A=20gNLQe+XN7kvDwGu0jYhTIZO10jcVsRSrAJ
	GtgBNrYxOjEUhpnaSJDVcjapRvRPCQumA13Zkl=0D=0A=20nm4AYjp7L2oOIeOGc
	KRZwbrGDakksa5iaSIoywpwECWh2l9V0W3SeynBgPtR4qpt4N8yKCcw=0D=0A=20
	suLCAKfBv9RcL641XZi/Fp9btSuTPUm5Lw3SIGr5U+SyezmhzlwsObIF9W624aor
	riWoXNf3=0D=0A=20GgH9ZH0Hkc6aS99pIZhh5USWRO/pS+lv5eNkEdf9LUBGX9b
	6ZMan0fpoEayqUejtZw3O2rgs=0D=0A=20zA+pTSA+/HobvtL6L3XtlPJ1NXlkgM
	7BTQRMC5TtARAA88hJdpgcg2RU/uAWfAL46XZHA59c=0D=0A=20VpPNNly1tPWCS
	bG6+ONH6nOG/NarmNVxX6Mb9YRkEU6wmrZS85inz3otdyz/zlyNSWma8qGN=0D=0
	A=20UlMbiwFQqfXWVBAPGoRC0a0aJrd4IayLuvv1UqEwx7Otp7y5RNHtRv35/kho
	0Z+UheYVdGm2=0D=0A=20I06xIc+aNKW2LO7R5BNtjpADPIG+NSdsVIeamhAWPvL
	rwbf6mUb//eA9pF0w0QixLVrH/cCo=0D=0A=20z+S27gCGJvY6zF22NgdhnkIqNz
	8E/LKt6S36ZI9Mw/ixpQTozqRmdNzVQNgTHUZClbJj4iq1=0D=0A=20EPHB7Xqpx
	Ov+awrxSxq2jt8GFD0rU+sAuzW+F7cBoIw434/IrxKYwcPHpHLEVQ1tLP7d3ZpZ=
	0D=0A=20R30p3oqoliGiLsWvHHxyXjuMBF4XJ6MRXmD65/qOhuo2DKduHMNlmxzg
	SzvWgXZeNJq+OcS8=0D=0A=20jQZDt2Na2pMKjWytau7xQu2ndm0FwS48ngMrDYR
	QMxzL1NfnBnT9BCwjiU+/6NBSwcNKIqye=0D=0A=20a9IpTwsVfkF4/iui7xD9+L
	tzqeUkBAe7q5jEJmJMZhAfh7usZGT8TGxXegCaF4Jwz2nxS4Fv=0D=0A=207VRza
	/yUAOJlc0daR11TPeiUNCQWY7PpL1AXO9vaSyjFuOzTnU8vzXvI9fGoxIxKGRQpK
	MU8=0D=0A=20PROIFw0AEQEAAcLBXwQYAQIACQUCTAuU7QIbDAAKCRD3enNVkraa
	BIxXD/4xlaBwW2TLFfMv=0D=0A=20lcY/2XDSm6NO4JaJG2Nzp35xaaBVwMVzWvI
	+GgTgKNSFot9f4jiLBNQdnq3UKoEThR2ORKVL=0D=0A=200ZJS1QYR7yyrOo0Mte
	DSy8ofU1FJ6xu4ND3ekOjP20BTrihDpqUdahir2uaRfMkwM+0imOlc=0D=0A=20u
	tGMhJNF/LAjrhoDp9SeDMYBXZ1wfrbrEo/EEu0PbkGyzqPyEPqwN1iSJkcAnjuIA
	0rTf1jQ=0D=0A=20tJAaDov7yHsSRwUM+qTGsjOGQAN3wtYwjPpw7hI01sE+x0uq
	0pVeo4qeWTZ2TE4Vtp8FKXFA=0D=0A=20kqnP878q+kNk9Ve+DRs8UlRfa9Lgf5E
	TjXOTVGaT/UGxi9B4oo8k0lzvM/A1txexL/lLw8AU=0D=0A=20LhUeGtyS6D2X9v
	Fi6azna+o918R9BV86uXPiDOf1nMwqKchNCxmgH9vd0aQm8TKCrWAW4kU1=0D=0A
	=20Ig6aMNuZiWloVZfKrmWizbgeGKE9rhNPNqxkqBaA4lrJ8L6bdKbhAOe3NQjO2
	vUAXB53Jphl=0D=0A=20F74GwEsh+85i9/yIbvwJVcsFYhdZz7fCAUOcnFkGnyrw
	IgkizQ3xXShPW8mqkgUk4kYMnucC=0D=0A=204kG/E7pI/4lke5X5X9vroXRHB7t
	kpAgT46SqSM/XTwCaseXG9orDgz3duRTUp6K0++S/qsqT=0D=0A=20akGVmjD591
	7A1HqWfMmiKA=3D=3D|Organization:=20AuriStor,=20Inc.|Disposition-
	Notification-To:=20Jeffrey=20E=20Altman=20<jaltman@auristor.com>
	|In-Reply-To:=20<20260515230516.2718212-1-dhowells@redhat.com>|C
	ontent-Type:=20text/plain=3B=20charset=3DUTF-8=3B=20format=3Dflo
	wed|Content-Transfer-Encoding:=207bit; bh=tJs+Q4IlG7uNVbFLyWC8CY
	dbDIFQca45o7QTKYtjxyw=; b=kcQ+ze50GyKv8EhtaW6zwwekdxT5fr5ak7ZbfK
	slPD0jglSXalVuLiaCl54CbqVxpyniTiTET9rg6EcH/F9k6ILR/Qpv/MUjQ/Tu6w
	V+dYFtgRN1UX+XiRkZYyI9VI37flO2DaOsChEKPrMiVEBOfSnXbrUfuIt7cIDH7t
	zK3Bs=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Wed, 20 May 2026 10:04:16 -0400
Received: from [IPV6:2603:7002:100:8400:fc83:8701:b9e7:aab8] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.0.2) 
	with ESMTPSA id md5001005293001.msg; Wed, 20 May 2026 10:04:15 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Wed, 20 May 2026 10:04:15 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7002:100:8400:fc83:8701:b9e7:aab8
X-MDHelo: [IPV6:2603:7002:100:8400:fc83:8701:b9e7:aab8]
X-MDArrival-Date: Wed, 20 May 2026 10:04:15 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1600c30037=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: netdev@vger.kernel.org
Message-ID: <e777cd2b-82be-46c3-8ebf-bddf502b450d@auristor.com>
Date: Wed, 20 May 2026 10:04:47 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 0/3] rxrpc: Better fix for DATA/RESPONSE decrypt vs
 splice()
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>, Marc Dionne <marc.dionne@auristor.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260515230516.2718212-1-dhowells@redhat.com>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Autocrypt: addr=jaltman@auristor.com; keydata=
 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
 akGVmjD5917A1HqWfMmiKA==
Organization: AuriStor, Inc.
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <20260515230516.2718212-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDCFSigsAdded: auristor.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	HEADER_FORGED_MDN(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289956-lists,netdev=lfdr.de];
	HAS_X_AS(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,auristor.com,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaltman@auristor.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[auristor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,auristor.com:email,auristor.com:mid,auristor.com:dkim,sashiko.dev:url]
X-Rspamd-Queue-Id: 3980E58F811
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/2026 7:05 PM, David Howells wrote:
> Here are two patches containing better fixes for the in-place decryption of
> DATA and RESPONSE packets that can corrupt pagecache spliced into UDP
> packets and sent to an AF_RXRPC server [CVE-2026-43500], plus a patch to
> precheck the length of rxgk-secured DATA packets.
>
> Of the main patches, one patch fixes DATA decryption by having recvmsg
> unconditionally extract the data into a flat bounce buffer and, if need be,
> decrypt it there.  It doesn't seem to cause a performance problem to do
> this even on unencrypted packets; for encrypted packets it makes sure the
> content is correctly aligned for crypto which seems to get a small
> performance gain.
>
> Further, it means that DATA packets are no longer copied in the I/O thread,
> avoiding a slowdown of the protocol engine that runs there.
>
> The other main patch fixes RESPONSE decryption by having the connection
> event handler worker copy the data to a flat buffer and, again, decrypt it
> there.  This simplifies RESPONSE handling.
>
> With these two fixes, the data content of the received sk_buff no longer
> gets altered.
>
> David
>
> The patches can be found here also:
>
> 	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes
>
> Changes
> =======
> ver #4)
> - Updated to current net/next, dropping Hyunwoo Kim's patch.
> - Don't allocate more than 65535 bytes of buffer so that ->rx_dec_bsize won't
>    overflow.
> - Fixed Sashiko review comments[3]:
>    - Fix incorrect ticket length limit.
>    - Don't need the MSG_PEEK limitation; can avoid this by checking seq of
>      skbuff being recmvsg'd against the one on record for the content of the
>      decryption buffer and (re-)decrypting if it doesn't match.
>
> ver #3)
> - Fixed Sashiko review comments[2]:
>    - Fix wrong abort codes.
>    - Fix skipped rxgk_put.
>    - Fix some mis-sizeofs.
>    - Fix flipped length check comparison.
>
> ver #2)
> - In rxrpc_verify_data():
>    - Flipped the order of the buffer size comparison.
>    - Used max() not umin() to calculate the minimum buffer size.
> - In rxrpc_verify_response(), returned -ENOMEM rather than uninitialised
>    ret.
> - Removed the xdr wrappers that were added to make backporting easier.
> - Fixed Sashiko review comments[1]:
>    - Added length prechecking of received packets secured with RxGK, thereby
>      avoiding looking at an unallocated buffer.
>    - Added missing crypto free.
>
> [1] https://sashiko.dev/#/patchset/20260511160753.607296-1-dhowells%40redhat.com
> [2] https://sashiko.dev/#/patchset/20260513131941.1439155-1-dhowells%40redhat.com
> [3] https://sashiko.dev/#/patchset/20260514155304.2249591-1-dhowells%40redhat.com
>
> David Howells (3):
>    crypto/krb5, rxrpc: Fix lack of pre-decrypt/pre-verify length checks
>    rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in
>      recvmsg
>    rxrpc: Fix RESPONSE packet verification to extract skb to a linear
>      buffer
>
>   Documentation/crypto/krb5.rst |  17 +++-
>   crypto/krb5/krb5_api.c        |  54 ++++++++++--
>   include/crypto/krb5.h         |   9 +-
>   include/trace/events/rxrpc.h  |   1 +
>   net/rxrpc/ar-internal.h       |  14 +--
>   net/rxrpc/call_event.c        |  22 +----
>   net/rxrpc/call_object.c       |   2 +
>   net/rxrpc/conn_event.c        |  32 +++----
>   net/rxrpc/insecure.c          |   8 +-
>   net/rxrpc/recvmsg.c           |  68 ++++++++++++---
>   net/rxrpc/rxgk.c              | 160 ++++++++++++++--------------------
>   net/rxrpc/rxgk_app.c          |  46 ++++------
>   net/rxrpc/rxgk_common.h       |  66 +++++++-------
>   net/rxrpc/rxkad.c             | 115 +++++++++---------------
>   14 files changed, 309 insertions(+), 305 deletions(-)
>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>


