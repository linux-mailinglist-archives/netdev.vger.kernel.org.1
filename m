Return-Path: <netdev+bounces-263418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDV4LpBMp2l2ggAAu9opvQ
	(envelope-from <netdev+bounces-263418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:03:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BE21F7153
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 978F9306ABD8
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1B233D507;
	Tue,  3 Mar 2026 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PYeLBOpF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C138C2C1
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571752; cv=none; b=ilVIQCoIPHJ7FExdir3+3Sx/jwYU5fHR1T9w4AweF8s+oBpx7NryBdYDphUBs26wCzKbQUXJJv33nRqKdzKOJERedLYBqgWWgdGkC1MVIejfgW7ikQnyauY/xEt6bsRhteyLCvj4Tnfa5nBUiSKYrzU9J9bqSzSX3nirgl8iIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571752; c=relaxed/simple;
	bh=f/+1RBFwBccQqW3tCR3yuiRjDYKCX/PF0bqKRX9TlKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8XjOXK4y+JYUE3ROyy9TkR+omAK8Go2GUJGwf8A+IedUPlDx2XRlcShJMG3gG00iXFEcxW8foYUUNW3VRq3wKdibzs4RlHxWr9yzMsSYq/YZAXkQvGKUgWyieUhw2jzPcgqzpBeOov1K0afMrbLfBi54PKTB7eIxFnMx22jdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PYeLBOpF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483abed83b6so51242125e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 13:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772571747; x=1773176547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/GbS8PQU6G4qit6IliiyF3U5xjyHPftLIsLjIMv3Bko=;
        b=PYeLBOpF/EePrGptBlbryytVbBPDTEAUFhvIw6OXidUi2L9NpsmLZmhcnClNxX34Ch
         nwQTteZrPvZKxAQvPDVgA+Ve7M7aqLFqyiIEmJoTEs2hjxrYFZyrPsD6kYfb9DtihSi+
         GUBf0IcJJCV/2qc+eyeZIu2+UoR5yBz/mH9YHK+/eCxQZz2fVgke86/5m8xJC9fhfhr3
         x7OXYHNIqxPA8GEW24aeSOD3yX5IioHrjKOATRm+MO7TVY8vTiDJ6cfkqK5lNbZ1nfRP
         qHKDGGOdJpH0U2Xgv7ZKB9+LpZ043Iwuhy5hxBUGpppT5ieKrhEMmWqXBDa5G0OOaEI0
         75TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772571747; x=1773176547;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GbS8PQU6G4qit6IliiyF3U5xjyHPftLIsLjIMv3Bko=;
        b=oFsvlOj2KmfZk2vrUsMgLVc2il4zyzMRRjhbj4jFpbk2KSEh539HdVPoruaYHFfRH9
         ENaUAnBO5DSIzsT9wydZsx6AObwIP/lAsbiJ2EXYvUP2D4nXzP4MCUZdZvl/L7/vXPmg
         IxQLsNVIwPKZ+91qQ2YG1jScElEcKwxTB89rrhACxa81PCzJYP+pTTCUcIu2mUmkoDfE
         CI+XTtsFQJ/sQnnj+RElS1RW97jLdrjRW9Pur0Tvyv2yAsQdgXMX2ZsSUXQ9CT+dtpV0
         mOqP8FHflFt5MF3tIoO6NGsMOxM9ZZnCc0b032g4UpDIWVX42mXStYEM0NLWAWKnP+du
         cdqA==
X-Gm-Message-State: AOJu0YxOBC1H7Lg4Z2BY9ZalJIUqx0nO+B7RAn67082/3dMLjbrc9R2c
	TSEMbUhPhmgAAF71JWs8125Vin1tLTbbvZusqzjW/CMkxLHgtCWkq7pGipNwDCe52iFPeAeJgYi
	OananQ+n+lnE79VCZkqFSPp0R434MKQNZD0bHLKeHTCJmnKPGDjI=
X-Gm-Gg: ATEYQzwLjmTzn3s3F+jy45DQkfm7NKxc0fFkddtmkt5qzx/PYirSNLtRmv+JI2EQXLY
	h+NkXrTmgyJQP08WjfupaCFagKlf+AZjHE5f8Z8DrcsItRRgeJSVuCWmLnOlFgJndL9dYFP2XGU
	iSx07p2NqNbN1DnUZSb0bZ1fuvaX0xa26HJAhuzg3wohJIuhiK4OC4DGCCZpbNAnadCf04V/ty3
	U/f2QAvrKjmG/w0riAwOOfOn3gL0o6nS58OCOUztNMc5RHnC1r3REENo5PpdHQQr2g6sP3bsaRs
	wnYb5k+y/Oo203yFf/YzCzVYjMmqE4uVoajLNiBLJMleEOLnZy/BFKaYezfn3lym83E9D1SFQ8E
	ZnZY/pWUtoH8Dlyul52WqnQBEBkevQPOyVQacM+G4JqWgjiPsv6RZbURYFgOZBFV3j4b0Ikxjc9
	nPBJGTSMxt6giyTkRwZyvzOvk1VUAhBE58cPw+nhu0phTgbC3TJAcX0i2vf43yNA==
X-Received: by 2002:a05:600c:4fc8:b0:483:6f37:1b51 with SMTP id 5b1f17b1804b1-483c9bedb07mr348191455e9.23.1772571746722;
        Tue, 03 Mar 2026 13:02:26 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:8c1b:8bca:3273:e279? ([2001:67c:2fbc:1:8c1b:8bca:3273:e279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851880724esm7472085e9.9.2026.03.03.13.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 13:02:26 -0800 (PST)
Message-ID: <74f8c9d9-eac7-4681-b3ee-8ab2b20b7904@openvpn.net>
Date: Tue, 3 Mar 2026 22:02:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] pull request: ovpn 2026-02-28
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
 Paolo Abeni <pabeni@redhat.com>, Ralf Lici <ralf@mandelbit.com>
References: <20260227235955.660-1-antonio@openvpn.net>
 <433139b8-3aea-4db1-8ed6-959ac445cd27@openvpn.net>
 <20260228170104.1ec4c133@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260228170104.1ec4c133@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 51BE21F7153
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263418-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,openvpn.net:dkim,openvpn.net:mid]
X-Rspamd-Action: no action

Hi!

On 01/03/2026 02:01, Jakub Kicinski wrote:
> On Sat, 28 Feb 2026 21:49:08 +0100 Antonio Quartulli wrote:
>> On 28/02/2026 00:59, Antonio Quartulli wrote:
>>> Hello netdev team!
>>> Here is our first batch of new features for ovpn.
>>
>> Please drop this PR.
>>
>> The automatic checks on patchwork have highlighted a few things worth
>> fixing (and the AI even found a real bug in the selftest Makefile!).
>>
>> Will resend the PR after fixing all issues.
> 
> Hi! I am trying to add ovpn to our netdev CI (Fedora 43).

Oh that's great!

> This is what I see without this series applied:
> 
> TAP version 13
> 1..7
> # timeout set to 45
> # selftests: net/ovpn: test-chachapoly.sh
> # Creating interface tun0 with mode 1
> # Creating interface tun1 with mode 0
> # Creating interface tun2 with mode 0
> # Creating interface tun3 with mode 0
> # Creating interface tun4 with mode 0
> # Creating interface tun5 with mode 0
> # Creating interface tun6 with mode 0
> # unexpected base64 error1: BASE64 - Invalid character in input (-44)
> # Error: invalid arguments.

Yeah, this is an issue with mbedtls3, and patch 1 is indeed fixing also 
this.

> #
> 
> And then it hangs. When I run the tests with this series applied
> its still broken but at least doesn't hang (see below)
> 
> What am I missing?
> 
> # make -C tools/testing/selftests/ TARGETS=net/ovpn run_tests
> make: Entering directory '/srv/vmksft/testing/wt-test/tools/testing/selftests'
> make[1]: Entering directory '/srv/vmksft/testing/wt-test/tools/testing/selftests/net/ovpn'
> make[1]: Nothing to be done for 'all'.
> make[1]: Leaving directory '/srv/vmksft/testing/wt-test/tools/testing/selftests/net/ovpn'
> make[1]: Entering directory '/srv/vmksft/testing/wt-test/tools/testing/selftests/net/ovpn'
> TAP version 13
> 1..8
> # timeout set to 45
> # selftests: net/ovpn: test-chachapoly.sh
> # Creating interface tun0 with mode 1
> # Creating interface tun1 with mode 0
> # Creating interface tun2 with mode 0
> # Creating interface tun3 with mode 0
> # Creating interface tun4 with mode 0
> # Creating interface tun5 with mode 0
> # Creating interface tun6 with mode 0
> # kernel error: Unknown attribute type

Maybe you didn't unload the ovpn.ko you built *without* the patchset 
applied?

This line above makes me think you are using the newer selftests (from 
the patchset), but without kernel support for a new attribute, 
introduced in patch 6.


Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


