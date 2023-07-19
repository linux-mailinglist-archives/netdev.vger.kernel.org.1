Return-Path: <netdev+bounces-19188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9159759E33
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3089281AEA
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70B526B6C;
	Wed, 19 Jul 2023 19:00:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09E26B67
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:07 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA0C1FD2
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id E532FD7650;
	Wed, 19 Jul 2023 20:52:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792735; bh=/Bd90abGQ/JFHWJA+jJnYCexfjn2h09m9yNN/bME97w=;
	h=From:To:Cc:Subject:Date:From;
	b=u3GgwNqxpaYRG0Jo8n5pdMutFp4digPX51FlsB6fPDWYGqlaoqBcvi/26aoARMaqo
	 YxEj8QFA44TdMPlkVLHBFtdpagEysggqAIcaAYnoy5qVtSWHAoby0oduzAdHCwvZDQ
	 N7yBTM86YpGQsCscS+2YemY+6VI64fzPAGWa89OnA/j/w3VaM+Jpm3mosMN6DXbfrY
	 CapAQNaOokZnfB6nNrGthr8cUXVZMeXNTTNbPwcMrFLD5VFttGTWT5QYmW2F6Qb+lw
	 iUEVO4aZJxOeRHexT3Gq6mR7zVZquG04k+AdUhwTePY32M6eU2qQWeMzVsETpCszEO
	 KxErwzGK41uow==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 00/22] Support for stateless configuration (read from /etc and /usr)
Date: Wed, 19 Jul 2023 20:50:44 +0200
Message-Id: <20230719185106.17614-1-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear iproute2 maintainers,

this patch series adds support for the so called "stateless" configuration
pattern, i.e. reading the default configuration from /usr while allowing
overriding it in /etc, giving system administrators a way to define local
configuration without changing any distro-provided files.

In practice this means that each configuration file FOO is loaded
from /usr/lib/iproute2/FOO unless /etc/iproute2/FOO exists.

Gioele Barabucci (22):
  Makefile: Rename CONFDIR to CONF_ETC_DIR
  Makefile: Add CONF_USR_DIR for system-installed configuration files
  include/utils.h: Use /usr/lib/iproute2 as default CONF_USR_DIR
  tc/tc_util: Read class names from provided path, /etc/, /usr
  tc/m_ematch: Read ematch from /etc and /usr
  lib/bpf_legacy: bpf_hash_init: Relay returned value
  lib/bpf_legacy: Read bpf_pinning from /etc and /usr
  lib/rt_names: rtnl_hash_initialize: Relay returned value
  lib/rt_names: rtnl_tab_initialize: Relay returned value
  lib/rt_names: Read rt_protos from /etc and /usr
  lib/rt_names: Read rt_scopes from /etc and /usr
  lib/rt_names: Read rt_names from /etc and /usr
  lib/rt_names: Read rt_tables from /etc and /usr
  lib/rt_names: Read rt_dsfield from /etc and /usr
  lib/rt_names: Read group from /etc and /usr
  lib/rt_names: Read nl_protos from /etc and /usr
  lib/rt_names: Read rt_protos.d/* from /etc and /usr
  lib/rt_names: Read rt_protos.d/* using rtnl_tab_initialize_dir
  lib/rt_names: Read protodown_reasons.d/* using rtnl_tab_initialize_dir
  lib/rt_names: Read rt_tables.d/* using rtnl_hash_initialize_dir
  man: Document lookup of configuration files in /etc and /usr
  Makefile: Install default configuration files in /usr

 Makefile                 |  10 +-
 include/utils.h          |   7 +-
 lib/bpf_legacy.c         |  12 ++-
 lib/rt_names.c           | 217 ++++++++++++++++++++++++---------------
 man/man8/Makefile        |   3 +-
 man/man8/ip-address.8.in |   5 +-
 man/man8/ip-link.8.in    |  12 ++-
 man/man8/ip-route.8.in   |  43 +++++---
 tc/m_ematch.c            |  17 ++-
 tc/tc_util.c             |  18 +++-
 10 files changed, 214 insertions(+), 130 deletions(-)

-- 
2.39.2


