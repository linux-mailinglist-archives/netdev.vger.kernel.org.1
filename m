Return-Path: <netdev+bounces-283749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KGYKh9b+GlStQIAu9opvQ
	(envelope-from <netdev+bounces-283749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:38:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF9E4BA55D
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F6A3301E97B
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9560533FE06;
	Mon,  4 May 2026 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CTw0wGJM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B69340260
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883717; cv=none; b=dnYnVIliGd8l4cVND4IqGePhq+yliG/e6x6XoYUaXF77EYIbY777qaOrJRnoL93KzEMVyjCng5SvuvToG7mThx2K5V0Kwp54g53IgXwtO9IaD0eUb4j14cKWU0xFQcaM5d/biK6+r9j91BbUzd4rRbs6fM/ojfw8ViUuNLqJ0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883717; c=relaxed/simple;
	bh=jmrPAuxpdKeQod6MHuVAPPLdL2cXYKYiSRob3cPatmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FySLtPvSs5ZE9zseuTovngWBJODOwZoPI/cuv1L82IjRoUw/nReH0iwoDYbu4szqkhT3wVZ5diL1sbmlp3KiyaI8T8XLSL/Eu7lnYxzdv8lcWxuxO9lBOHC4hX+Fc8zesGK/9707NQnGhMzk02D/xyNiQ5QUlDjXBcasUQyamfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CTw0wGJM; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-900fa9f178dso143358585a.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777883715; x=1778488515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/9O86zTwFBKohnDw3dwAE/1O4/dVfxsou41FQchDbs=;
        b=sqd9z2mWrcWR2VwcYupvuhYnv2Blt6GoyMwIAFj8oifmknwsTuvamer4j+7Ixrlqfo
         lLse/A8cxz7Bvg5SEB5ZGKhyuMkVUFNEcsuFWjiJ6iqKnh8Vzk/wdP7q33IiSrJNx9IO
         /RKOCfSOu7V0W2D/Vvs3ytV8OtJML8qha6iybdCt9SjwZ5eq0ILb6ohPN0TOo6vYcH9S
         v4dx/uvtiSsqMU9so3Pd5Q0C9gBwIX+ZSH0GG8JUB02hSaKm9el8ZrTOyA/3meU6o4Dk
         uMVYrzkGdJpQvMQhOwtKSqma0UH+f5D0ehFfVi7NcUWsa4Or9Puf2YGtxepuQsR+S4Tu
         I7rA==
X-Forwarded-Encrypted: i=1; AFNElJ83KBcZxvfA+xC7unLUB9EsoKrpAY0+YNoDoL7xcUt7819bb3Y1QPh6rL/vY8O8mmIR1eB7+nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMmqP/ncZ4a2IR0fndl1YC0mH1x4hg+vh8ob60wfUqJKEBi4t
	rt01jcYFQZeuvT1BV+Qh6OQ+5JngRZRB+3b+LTSg/JcesJ46PUXLNcF0vNuJMEg061jXWFxsbNo
	k4u4AjSkmAafGcE67N+EhK684k5EUMw+AKYTMco9hucaApH+nf9WB71zsZoV90hZ57Kw5yyVYxP
	ECaoJgnUwlX5aZ0O4Ml86wX2EhXaJCpaaPR4crhI6DMT3XCjJl8rCSS+qS0Ms82LoHEgjRDwryX
	PhVN0NkCwM=
X-Gm-Gg: AeBDietalAHwV8NRmKeJ5dl+1iy3Ooh/+dm7Px5RinuKRRW6cNyUa/u8lZP43fOfT/y
	FEqP4VtFsWJRxDsu4riTjntG3BLQsiplTKcbl1NhvpJ27kTlXlcMYPhBdf29CBAew+DlakYonou
	KaqZlsURrihPyjnOo8sVsKZPoE0eCXkjAD4LsWBmo7rQZe92zEiRwS93Nq/Tyl+jRVaeFKTVN9F
	nQftq+ykUmEWCTTpX7GiARSyH8WGRx/gfb+aSk8b0nwhCg8IwwBXSHUYj73JfTRhgtVLxUW5aXg
	oSY0rQqAqdhpZ+erY4pMwZuAk08DDHmSZCILTgL5BuK6JD/jmvwR+vN493ictu5Wo7KNhW3lkRn
	0ytSz1JGHxgJAvgSLxBAdVZUhfYfrG6ql6Uqqq9lFw3E4/2beSdyRi7+d53cQXz3IZnTsur7mxk
	K7yedjzEUlX5lEkQpMr27CQptyLF6uzXx/9ODfyJdhSvkFXxENIt9xakcRlvvJDvns89E5ng==
X-Received: by 2002:a05:6214:4485:b0:8a4:5cfe:a204 with SMTP id 6a1803df08f44-8b667698cdbmr172236136d6.26.1777883714899;
        Mon, 04 May 2026 01:35:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b537e7ef14sm8451276d6.2.2026.05.04.01.35.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 01:35:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f9f49e4beso2260764b3a.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777883712; x=1778488512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/9O86zTwFBKohnDw3dwAE/1O4/dVfxsou41FQchDbs=;
        b=CTw0wGJMJzsnsc/PiX8TCJhlG83AyHPss9ihhBMZtOGF0tBGoFDxsz6YWd54fccv7s
         LDzN/BcPbueWQq7i4+Lyly+7+45/QcUuTDBZjez626CvpojAq+4nkVOafEbW9frXYex/
         SHmrJy2yfwafHtp987iyEJLJGKjKmCGehezT4=
X-Forwarded-Encrypted: i=1; AFNElJ98DyJbmOKUWQqwAEqQ14J2Up0c9S7UFkfx6HryJ7qH4M1WfVwy92TlAk0y5M1hFKLzPKM5ND4=@vger.kernel.org
X-Received: by 2002:a05:6a00:2d8b:b0:82f:776f:a78d with SMTP id d2e1a72fcca58-8352d1a68admr8320438b3a.19.1777883711921;
        Mon, 04 May 2026 01:35:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d8b:b0:82f:776f:a78d with SMTP id d2e1a72fcca58-8352d1a68admr8320410b3a.19.1777883711422;
        Mon, 04 May 2026 01:35:11 -0700 (PDT)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0183sm12539773b3a.31.2026.05.04.01.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:35:10 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net 0/4] bnxt_en: Bug fixes
Date: Mon,  4 May 2026 14:06:07 +0530
Message-ID: <20260504083611.1383776-1-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 2BF9E4BA55D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283749-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]

This patchset adds the following fixes for bnxt:

Patch #1 fixes DPC AER handling to make it more reliable

Patch #2 fixes incorrect capping bp->max_tpa based on what the FW
supports

Patch #3 fixes ignoring of VNIC configuration result when RDMA
driver is loading

Patch #4 fixes logic to make phase adjustment on the PPS OUT signal

Kalesh AP (1):
  bnxt_en: Check return value of bnxt_hwrm_vnic_cfg

Michael Chan (2):
  bnxt_en: Delay for 5 seconds after AER DPC for all chips
  bnxt_en: Set bp->max_tpa according to what the FW supports

Pavan Chebbi (1):
  bnxt_en: Use absolute target ns from ptp_clock_request

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 16 +++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 29 ++++---------------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 10 +++++--
 3 files changed, 25 insertions(+), 30 deletions(-)

-- 
2.52.0


