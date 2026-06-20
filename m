Return-Path: <netdev+bounces-300791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CL3pACZfNmpL+wYAu9opvQ
	(envelope-from <netdev+bounces-300791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:36:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DF36A8AED
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:36:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j+40fQog;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300791-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300791-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E706E30226AF
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546E43403F1;
	Sat, 20 Jun 2026 09:36:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065919CCF7
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 09:36:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781948195; cv=none; b=Gq7B79xB/1lSkcUSOwyQ0I2oOwdBJZe37fuhS9ZywfVD4fgL7uOqHQDLATHI91mrsWyIwIujoiCTLEZAF4fEC4mgF+MQRvkCvd8RuTuwjDr4mMWcYxp2s+eh56eHEDzmABez9S6fKtfSxLY0IkVkbj/pXuHaP/7c2pXDxBmOr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781948195; c=relaxed/simple;
	bh=bU4r3vVkW8mrONjfwTJWC9BvWthCSpu4DsLPxMaedmI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=n7LnCdIL9qwkXxeMF9+YlO+7JybS217zwkDr2bkqql5yGyyo9dCaAttTnYgNRfbPnrbPeBWlwi7v5l7UvKFhkc38DeS6Nxya6bCZcF1psKwWwuzNvPASuCgp1F6ppv8+EgeAGlXfUyn67CdJYwWo0FsZOPupUzESMP1ZMrb1BLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+40fQog; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4905529b933so26937765e9.0
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781948192; x=1782552992; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fq7/gXiRYl+tPp5LSIPTHcs/K7+qpSBcoeo/PpCpVqw=;
        b=j+40fQogpp6CphwuvtHzstkmHzSnqpL1QbKyT9TBbYYH81SkWPV9EjFzAwE/Ohk9lC
         jd9/2kGraa6+02AnWaTVFKYZ4pwDm9dl/3Wqsl8V7HKNMw9MNLJJBe6DIyIv7zfMXF6f
         RjX+gSKi+rEol/uMnYPUNN1Oguy+zM1hVS5WYOFMmAt4CvKkepbKncgKXAPKDJjrQW3i
         AEzSV2RJgGJrKL+gwk8s7wilnrs4GqnzL+6TqVBkJA9ozajgZ/pGo1RUKCapZBTHQt5s
         AxQg2OFeFl8ZG425Hw0GCF0ociLa+T1EPxfMD4/p3s3zptyYmTooVabZAoFTuuNnV2u1
         4cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781948192; x=1782552992;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fq7/gXiRYl+tPp5LSIPTHcs/K7+qpSBcoeo/PpCpVqw=;
        b=KisqJGTIXksgW0Q962GrEFALdfPbYIMfAw3vJSD4QbYN5FJ5bvnf2xfYy2qwDllRJl
         hpx2quzYLgkPk04BZ2mivCunzKYT2X0wPfPyaX9tbllkeZvEJltC+CXSHYYIRnVhbtTj
         eWCiPaIvByZ5kbpMTt1vq4zt33Qpy3iq/GQV7AUi65rJKUqBK4QR3tD4JHOyFQPOOj5f
         mzjUxQz0InrMvvXlRhH8yJhgh7WdJjK/xGHRpF9I+/DJxwFHAcSJQ4Vzn6piThKVzohB
         eeGMH+jcxG1mUiMBmqMuoJtgsK0BHQ+VjfriI62wvvMn4IeYsaBfrcvty0mXbemFFkzl
         VDew==
X-Gm-Message-State: AOJu0Ywz+B8aZUsiTXZaT8dR3aSnRGwruqLYkX4jYDqhc6UdTFyCO6os
	BkMvt26YlPXE4EPA/FVGmnnQLnV2INvrFi6E2BpeY7CpqraZ5ZHUZ5Yy04szaw==
X-Gm-Gg: AfdE7ckzZDyi1FNfmw35HEFZ9DOJRh82jAykQQbSmD9EIR+5LeBk0gEVod9JzytlBJg
	Og2/zsBZybwTfD8nUZpIRk7k4/T0+Oz/4MrXZhwIdRDwIVzOrK0ZUVXQ/HBGgceu6dNYQ23eMo4
	m6B3xv6ZYJIygVs3AbAvaRwakJhb7Jc5zkVwYz9JQOc9OohdY+YQiJhIjrMJjG5uKLvBveHCrzT
	zLcgNd995YAgChRgSAjsqtmOijMP+80hxgvnzLpN2320B1dxuyaQE1xaXDoRmhd1tE8co7gG7gn
	QRA4xWTwq0+x6r+PuBZQ/dSSBf8xtkEUxfMksXBaxT+q0l7NjesULPpYkpDv52W4IIZdcwCKqt0
	pMEsegwYeIfO46pPzI5w3Ss+ROVBTfYxatKsWucLIkxHe6Ra//avHP3kcEaOxGe3CDHbR3wFeXS
	wxFyTZypETBV7Jc9GzxYJi660sl27PYhpS1zsoGI5xZVkfa0QwIPO7qNo=
X-Received: by 2002:a05:600c:3baa:b0:492:42e1:1b6a with SMTP id 5b1f17b1804b1-49242e11d31mr99118375e9.25.1781948192290;
        Sat, 20 Jun 2026 02:36:32 -0700 (PDT)
Received: from ?IPV6:2001:bb6:1b96:9200:cf2e:dbb6:5a08:1ea4? ([2001:bb6:1b96:9200:cf2e:dbb6:5a08:1ea4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249207dabsm83771655e9.0.2026.06.20.02.36.31
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2026 02:36:31 -0700 (PDT)
Message-ID: <62f09fe8-899c-4d22-b7a1-67e2745613df@gmail.com>
Date: Sat, 20 Jun 2026 10:36:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Dmitri Seletski <drjoms@gmail.com>
Subject: "ip help" output is an error
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300791-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[drjoms@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[drjoms@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46DF36A8AED


Hello iproute2 maintainers,

I am reporting an inconsistency regarding the exit status of the ip help 
command.

Current Behavior:
When running ip help, the command prints the help documentation to 
stdout, but exits with a non-zero status (error). This causes issues in 
shell scripts that rely on exit codes for control flow.

Steps to reproduce:
bash

# This returns "FAIL" because the exit code is non-zero
if ip help > /dev/null; then
     echo "SUCCESS"
else
     echo "FAIL"
fi

Expected Behavior:
Since the command successfully performs the requested task (displaying 
help information) and does not encounter a system error, it should 
return an exit code of 0.

Context:
This behavior breaks standard Bash logic for automation. For example:
ip help && echo "This will not execute"

"ip help |grep br" - this will bring no result.

Current version tested: iproute2-6.19.0

Thank you for your time and for maintaining this tool.

Regards,
Dmitri Seletski


